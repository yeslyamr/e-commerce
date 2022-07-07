// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_publication_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostPublStore on _PostPublStore, Store {
  Computed<bool>? _$canPostComputed;

  @override
  bool get canPost => (_$canPostComputed ??=
          Computed<bool>(() => super.canPost, name: '_PostPublStore.canPost'))
      .value;

  late final _$titleAtom = Atom(name: '_PostPublStore.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$priceAtom = Atom(name: '_PostPublStore.price', context: context);

  @override
  double get price {
    _$priceAtom.reportRead();
    return super.price;
  }

  @override
  set price(double value) {
    _$priceAtom.reportWrite(value, super.price, () {
      super.price = value;
    });
  }

  late final _$postRandomAsyncAction =
      AsyncAction('_PostPublStore.postRandom', context: context);

  @override
  Future<void> postRandom() {
    return _$postRandomAsyncAction.run(() => super.postRandom());
  }

  late final _$postAsyncAction =
      AsyncAction('_PostPublStore.post', context: context);

  @override
  Future<void> post() {
    return _$postAsyncAction.run(() => super.post());
  }

  @override
  String toString() {
    return '''
title: ${title},
price: ${price},
canPost: ${canPost}
    ''';
  }
}
