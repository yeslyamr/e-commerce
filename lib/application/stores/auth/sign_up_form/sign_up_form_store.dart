// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'sign_up_form_store.g.dart';

class SignUpFormStore = _SignUpFormStore with _$SignUpFormStore;

abstract class _SignUpFormStore with Store {
  final FormErrorState error = FormErrorState();

  @observable
  String username = '';

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

  @action
  validateUsername(String input) {
    error.username = input.isNotEmpty ? null : 'Username should not be empty';
  }

  void validateAll() {
    validateUsername(username);
    validateEmailAddress(emailAddress);
    validatePassword(password);
  }

  @computed
  bool get canRegister => !error.hasErrors;
  // && emailAddress.isNotEmpty && password.isNotEmpty && username.isNotEmpty;

  List<ReactionDisposer> _disposers = [];

  void setupValidations() {
    _disposers = [
      reaction((_) => emailAddress, validateEmailAddress),
      reaction((_) => password, validatePassword),
      reaction((_) => username, validateUsername)
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
  String? username;

  @observable
  String? email;

  @observable
  String? password;

  @computed
  bool get hasErrors => email != null || password != null;
}
