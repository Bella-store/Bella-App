import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      String name = userDoc['userName'];

      // Save login state and user data in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('uid', userCredential.user!.uid);
      await prefs.setString('userName', name);
      await prefs.setString('userEmail', email);

      emit(LogingSuccessState());
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

      // Get the UID of the registered user
      String uid = userCredential.user!.uid;

      // Add the user document to Firestore
      await _firestore.collection('users').doc(uid).set({
        'userId': uid,
        'userName': name,
        'userEmail': email,
        'favouriteProducts': [], // Initialize with an empty list
        'cartProducts': [], // Initialize with an empty list
        'role': 'user', // Set default role as 'user'
      });

      // Save user data in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('uid', uid);
      await prefs.setString('userName', name);
      await prefs.setString('userEmail', email);

      emit(SignUpSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(SignUpErrorState(e.message ?? "An error occurred during sign up"));
    } catch (e) {
      emit(SignUpErrorState("An unexpected error occurred: $e"));
    }
  }

  // Logout function
  void logout() async {
    await _firebaseAuth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data
    emit(AuthInitial()); // Reset the state
  }
}
