import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_store_app/core/Utils.dart';

abstract class AuthenticationService {
  Stream<User?> get authState;

  Stream<User?> get userChanges;

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username});

  Future<void> signOut();

  Future<void> resetPassword({required String email});

  Future<void> sendEmailVerification();
}

class FirebaseAuthenticationService implements AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthenticationService(this._firebaseAuth);

  @override
  Stream<User?> get authState => _firebaseAuth.authStateChanges();

  @override
  Stream<User?> get userChanges => _firebaseAuth.userChanges();

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firebaseAuth.currentUser?.updateDisplayName(username);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    try {
      user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }
}
