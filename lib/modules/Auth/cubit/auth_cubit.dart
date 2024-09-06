import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login function
  void login(String email, String password) async {
    emit(LogingLoadingState());
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      UserModel userModel =
          UserModel.fromMap(userDoc.data() as Map<String, dynamic>, userDoc.id);

      // Save user data in SharedPreferences
      await userModel.saveToPreferences();

      emit(LogingSuccessState(userModel));
    } on FirebaseAuthException catch (e) {
      emit(LogingErrorState(e.message ?? "An error occurred during login"));
    }
  }

  // Signup function
  void signup(String name, String email, String password) async {
    emit(SignUpLoadingState());
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create a new UserModel
      UserModel userModel = UserModel(
        userId: userCredential.user!.uid,
        userName: name,
        userEmail: email,
        favoriteProducts: [],
        cartProducts: [],
        role: 'user',
      );

      // Add the user document to Firestore
      await _firestore
          .collection('users')
          .doc(userModel.userId)
          .set(userModel.toMap());

      // Save user data in SharedPreferences
      await userModel.saveToPreferences();

      emit(SignUpSuccessState(userModel));
    } on FirebaseAuthException catch (e) {
      emit(SignUpErrorState(e.message ?? "An error occurred during sign up"));
    } catch (e) {
      emit(SignUpErrorState("An unexpected error occurred: $e"));
    }
  }

  // Logout function
  void logout() async {
    await _firebaseAuth.signOut();
    await UserModel
        .clearFromPreferences(); // Clear user data from SharedPreferences
    emit(AuthInitial()); // Reset the state
  }

  // Check if a user is already logged in using shared preferences
  Future<void> checkLoggedIn() async {
    emit(LogingLoadingState());
    UserModel? userModel = await UserModel.loadFromPreferences();
    if (userModel != null) {
      emit(LogingSuccessState(userModel));
    } else {
      emit(AuthInitial());
    }
  }
}
