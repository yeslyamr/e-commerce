// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on _CartStore, Store {
  Computed<double>? _$totalPriceComputed;

  @override
  double get totalPrice =>
      (_$totalPriceComputed ??= Computed<double>(() => super.totalPrice,
              name: '_CartStore.totalPrice'))
          .value;
  Computed<bool>? _$canBuyComputed;

  @override
  bool get canBuy => (_$canBuyComputed ??=
          Computed<bool>(() => super.canBuy, name: '_CartStore.canBuy'))
      .value;
  Computed<int>? _$totalProductsComputed;

  @override
  int get totalProducts =>
      (_$totalProductsComputed ??= Computed<int>(() => super.totalProducts,
              name: '_CartStore.totalProducts'))
          .value;

  late final _$productsInCartAtom =
      Atom(name: '_CartStore.productsInCart', context: context);

  @override
  ObservableMap<Product, int> get productsInCart {
    _$productsInCartAtom.reportRead();
    return super.productsInCart;
  }

  @override
  set productsInCart(ObservableMap<Product, int> value) {
    _$productsInCartAtom.reportWrite(value, super.productsInCart, () {
      super.productsInCart = value;
    });
  }

  late final _$getProductsAndFetchCartAsyncAction =
      AsyncAction('_CartStore.getProductsAndFetchCart', context: context);

  @override
  Future<void> getProductsAndFetchCart(
      {required String category, required CartStore cartStore}) {
    return _$getProductsAndFetchCartAsyncAction.run(() => super
        .getProductsAndFetchCart(category: category, cartStore: cartStore));
  }

  late final _$fetchCartDataFromFirestoreAsyncAction =
      AsyncAction('_CartStore.fetchCartDataFromFirestore', context: context);

  @override
  Future<void> fetchCartDataFromFirestore() {
    return _$fetchCartDataFromFirestoreAsyncAction
        .run(() => super.fetchCartDataFromFirestore());
  }

  late final _$purchaseAsyncAction =
      AsyncAction('_CartStore.purchase', context: context);

  @override
  Future<void> purchase() {
    return _$purchaseAsyncAction.run(() => super.purchase());
  }

  late final _$emptyCartAsyncAction =
      AsyncAction('_CartStore.emptyCart', context: context);

  @override
  Future<void> emptyCart() {
    return _$emptyCartAsyncAction.run(() => super.emptyCart());
  }

  late final _$_CartStoreActionController =
      ActionController(name: '_CartStore', context: context);

  @override
  void incrementQuantity({required Product product}) {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.incrementQuantity');
    try {
      return super.incrementQuantity(product: product);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQuantity({required Product product}) {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.decrementQuantity');
    try {
      return super.decrementQuantity(product: product);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
productsInCart: ${productsInCart},
totalPrice: ${totalPrice},
canBuy: ${canBuy},
totalProducts: ${totalProducts}
    ''';
  }
}
