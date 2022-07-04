// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'sign_in_form_store.g.dart';

class SignInFormStore = _SignInFormStore with _$SignInFormStore;

abstract class _SignInFormStore with Store {
  final FormErrorState error = FormErrorState();

  @observable
  String emailAddress = '';

  @observable
  String password = '';

  @action
  void validateEmailAddress(String input) {
    const emailRegExp =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
    error.email =
        RegExp(emailRegExp).hasMatch(input) ? null : 'Email address is invalid';
  }

  @action
  void validatePassword(String input) {
    error.password =
        input.length >= 8 ? null : 'Password should be at least 8 characters';
  }

  void validateAll() {
    validateEmailAddress(emailAddress);
    validatePassword(password);
  }

  @computed
  bool get canLogin =>
      !error.hasErrors; // && emailAddress.isNotEmpty && password.isNotEmpty;

  List<ReactionDisposer> _disposers = [];

  void setupValidations() {
    _disposers = [
      reaction((_) => emailAddress, validateEmailAddress),
      reaction((_) => password, validatePassword)
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String? email;

  @observable
  String? password;

  @computed
  bool get hasErrors => email != null || password != null;
}
