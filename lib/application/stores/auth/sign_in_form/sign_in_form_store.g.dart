// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignInFormStore on _SignInFormStore, Store {
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin =>
      (_$canLoginComputed ??= Computed<bool>(() => super.canLogin,
              name: '_SignInFormStore.canLogin'))
          .value;

  late final _$emailAddressAtom =
      Atom(name: '_SignInFormStore.emailAddress', context: context);

  @override
  String get emailAddress {
    _$emailAddressAtom.reportRead();
    return super.emailAddress;
  }

  @override
  set emailAddress(String value) {
    _$emailAddressAtom.reportWrite(value, super.emailAddress, () {
      super.emailAddress = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_SignInFormStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$_SignInFormStoreActionController =
      ActionController(name: '_SignInFormStore', context: context);

  @override
  void validateEmailAddress(String input) {
    final _$actionInfo = _$_SignInFormStoreActionController.startAction(
        name: '_SignInFormStore.validateEmailAddress');
    try {
      return super.validateEmailAddress(input);
    } finally {
      _$_SignInFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String input) {
    final _$actionInfo = _$_SignInFormStoreActionController.startAction(
        name: '_SignInFormStore.validatePassword');
    try {
      return super.validatePassword(input);
    } finally {
      _$_SignInFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
emailAddress: ${emailAddress},
password: ${password},
canLogin: ${canLogin}
    ''';
  }
}

mixin _$FormErrorState on _FormErrorState, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_FormErrorState.hasErrors'))
          .value;

  late final _$emailAtom =
      Atom(name: '_FormErrorState.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_FormErrorState.password', context: context);

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
hasErrors: ${hasErrors}
    ''';
  }
}
