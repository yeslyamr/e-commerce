// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:test_store_app/domain/services/authentication_service.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final AuthenticationService _authService;

  _AuthStore(this._authService);

  late final ObservableStream<User?> authStateStream =
      ObservableStream(_authService.authState);

  late final ObservableStream<User?> userChanges =
      ObservableStream(_authService.userChanges);

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _authService.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username}) async {
    await _authService.signUpWithEmailAndPassword(
        email: email, password: password, username: username);
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _authService.resetPassword(email: email);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> sendEmailVerification() async {
    _authService.sendEmailVerification();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
