// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on _CartStore, Store {
  Computed<bool>? _$canBuyComputed;

  @override
  bool get canBuy => (_$canBuyComputed ??=
          Computed<bool>(() => super.canBuy, name: '_CartStore.canBuy'))
      .value;
  Computed<double>? _$totalPriceComputed;

  @override
  double get totalPrice =>
      (_$totalPriceComputed ??= Computed<double>(() => super.totalPrice,
              name: '_CartStore.totalPrice'))
          .value;

  late final _$collectionStreamAtom =
      Atom(name: '_CartStore.collectionStream', context: context);

  @override
  ObservableStream<QuerySnapshot<Object?>> get collectionStream {
    _$collectionStreamAtom.reportRead();
    return super.collectionStream;
  }

  @override
  set collectionStream(ObservableStream<QuerySnapshot<Object?>> value) {
    _$collectionStreamAtom.reportWrite(value, super.collectionStream, () {
      super.collectionStream = value;
    });
  }

  late final _$cartStreamAtom =
      Atom(name: '_CartStore.cartStream', context: context);

  @override
  ObservableStream<DocumentSnapshot<Map<String, dynamic>>> get cartStream {
    _$cartStreamAtom.reportRead();
    return super.cartStream;
  }

  @override
  set cartStream(
      ObservableStream<DocumentSnapshot<Map<String, dynamic>>> value) {
    _$cartStreamAtom.reportWrite(value, super.cartStream, () {
      super.cartStream = value;
    });
  }

  late final _$productsInCartAtom =
      Atom(name: '_CartStore.productsInCart', context: context);

  @override
  ObservableMap<DocumentSnapshot<Object?>, Product> get productsInCart {
    _$productsInCartAtom.reportRead();
    return super.productsInCart;
  }

  @override
  set productsInCart(ObservableMap<DocumentSnapshot<Object?>, Product> value) {
    _$productsInCartAtom.reportWrite(value, super.productsInCart, () {
      super.productsInCart = value;
    });
  }

  late final _$productsFromDBAtom =
      Atom(name: '_CartStore.productsFromDB', context: context);

  @override
  ObservableList<DocumentSnapshot<Object?>> get productsFromDB {
    _$productsFromDBAtom.reportRead();
    return super.productsFromDB;
  }

  @override
  set productsFromDB(ObservableList<DocumentSnapshot<Object?>> value) {
    _$productsFromDBAtom.reportWrite(value, super.productsFromDB, () {
      super.productsFromDB = value;
    });
  }

  late final _$purchaseCartAsyncAction =
      AsyncAction('_CartStore.purchaseCart', context: context);

  @override
  Future<void> purchaseCart() {
    return _$purchaseCartAsyncAction.run(() => super.purchaseCart());
  }

  late final _$addToCartAsyncAction =
      AsyncAction('_CartStore.addToCart', context: context);

  @override
  Future<void> addToCart(
      {required DocumentSnapshot<Object?> documentSnapshot,
      required Product product}) {
    return _$addToCartAsyncAction.run(() =>
        super.addToCart(documentSnapshot: documentSnapshot, product: product));
  }

  late final _$removeFromCartAsyncAction =
      AsyncAction('_CartStore.removeFromCart', context: context);

  @override
  Future<void> removeFromCart(
      {required DocumentSnapshot<Object?> documentSnapshot}) {
    return _$removeFromCartAsyncAction
        .run(() => super.removeFromCart(documentSnapshot: documentSnapshot));
  }

  late final _$fetchCartDataFromFirestoreAsyncAction =
      AsyncAction('_CartStore.fetchCartDataFromFirestore', context: context);

  @override
  Future<void> fetchCartDataFromFirestore() {
    return _$fetchCartDataFromFirestoreAsyncAction
        .run(() => super.fetchCartDataFromFirestore());
  }

  @override
  String toString() {
    return '''
collectionStream: ${collectionStream},
cartStream: ${cartStream},
productsInCart: ${productsInCart},
productsFromDB: ${productsFromDB},
canBuy: ${canBuy},
totalPrice: ${totalPrice}
    ''';
  }
}
