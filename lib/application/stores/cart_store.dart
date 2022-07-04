// ignore_for_file: library_private_types_in_public_api
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:test_store_app/application/stores/products_store.dart';
import 'package:test_store_app/data/repositories/store_repository.dart';
import 'package:test_store_app/domain/models/product.dart';

part 'cart_store.g.dart';

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  final productsStore = ProductsStore();

  final StoreRepository _storeRepo = StoreRepositoryImpl();

  // product to quantity map
  @observable
  ObservableMap<Product, int> productsInCart =
      ObservableMap<Product, int>.of({});

  @computed
  double get totalPrice {
    double res = 0;
    productsInCart.forEach((key, value) {
      res += key.price! * value;
    });
    return res;
  }

  @computed
  bool get canBuy => productsInCart.isNotEmpty;

  @computed
  int get totalProducts {
    int res = 0;
    productsInCart.forEach((key, value) {
      res += value;
    });
    return res;
  }

  @action
  Future<void> getProductsAndFetchCart(
      {required String category, required CartStore cartStore}) async {
    await cartStore.fetchCartDataFromFirestore();
    await cartStore.productsStore.getProducts(category: category);
  }

  @action
  Future<void> fetchCartDataFromFirestore() async {
    final firestore = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    final doc = await firestore.get();
    final cart = doc.get('cart');

    productsInCart.clear();

    for (var entry in cart) {
      final product = await _storeRepo.getSingleProduct(productId: entry['id']);
      productsInCart[product] = entry['quantity'] as int;
    }
  }

  @action
  void incrementQuantity({required Product product}) {
    if (productsInCart.keys.contains(product)) {
      productsInCart[product] = productsInCart[product]! + 1;
    } else {
      productsInCart[product] = 1;
    }
  }

  Future<void> sendToFirestore() async {
    final firestore = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    final doc = await firestore.get();
    final cart = doc.get('cart');

    cart.clear();
    productsInCart.forEach((key, value) {
      cart.add({
        'id': key.id.toString(),
        'title': key.title,
        'quantity': value as dynamic
      });
    });
    await firestore.update({'cart': cart});
  }

  @action
  void decrementQuantity({required Product product}) {
    if (productsInCart.keys.contains(product)) {
      if (productsInCart[product]! > 1) {
        productsInCart[product] = productsInCart[product]! - 1;
      } else {
        productsInCart.remove(product); //[product] = 0;
      }
    }
  }

  @action
  Future<void> purchase() async {
    final firestore = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    final doc = await firestore.get();

    final cart = doc.get('cart');

    await firestore.update({
      'purchases': FieldValue.arrayUnion([
        {
          'items': cart,
          'time': Timestamp.fromDate(DateTime.now()),
          'totalPrice': totalPrice as dynamic,
        }
      ])
    });
    await emptyCart();
  }

  @action
  Future<void> emptyCart() async {
    productsInCart.clear();
    await sendToFirestore();
  }

  Future<void> test() async {
    final firestore =
        FirebaseFirestore.instance.collection('publications').doc('qwer');

    await firestore.update({
      'pub': FieldValue.arrayUnion([
        {
          'asdf': 1,
          'asde': 'dfjghjk',
          'map': {'rating': 1.2, 'asdq': 'q'}
        }
      ])
    });
  }
}
