import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

void login(String email, String password) async {
  emit(LogingLoadingState());
  try {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    // Save login state in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    emit(LogingSuccessState());
  } on FirebaseAuthException catch (e) {
    emit(LogingErrorState(e.message ?? "An error occurred during login"));
    Fluttertoast.showToast(msg: e.message ?? "Login failed");
  }
}

  void signup(String email, String password) async {
    emit(SignUpLoadingState());
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignUpSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(SignUpErrorState(e.message ?? "An error occurred during sign up"));
      Fluttertoast.showToast(msg: e.message ?? "Signup failed");
    }
  }
}
