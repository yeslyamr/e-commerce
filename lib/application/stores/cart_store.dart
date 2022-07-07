// ignore_for_file: library_private_types_in_public_api
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:test_store_app/domain/models/product.dart';
import 'package:test_store_app/domain/services/firestore_service.dart';

part 'cart_store.g.dart';

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  final _firestoreService = CloudFirestoreServiceImpl();

  _CartStore() {
    fetchCartDataFromFirestore();
    collectionStream.listen((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docChanges) {
        switch (element.type) {
          case DocumentChangeType.added:
            productsFromDB.add(element.doc);
            break;
          case DocumentChangeType.removed:
            productsFromDB
                .removeWhere((d) => d.reference == element.doc.reference);
            break;

          case DocumentChangeType.modified:
            productsFromDB
                .removeWhere((d) => d.reference == element.doc.reference);
            productsFromDB.add(element.doc);
            break;
          default:
        }
      }
    });
  }

  @action
  Future<void> purchaseCart() async {
    final listOfDocSnap = productsInCart.keys.toList();
    await _firestoreService.purchaseCart(documentSnapshots: listOfDocSnap);
    for (var docSnap in listOfDocSnap) {
      removeFromCart(documentSnapshot: docSnap);
    }
  }

  @observable
  ObservableStream<QuerySnapshot<Object?>> collectionStream = ObservableStream(
      FirebaseFirestore.instance.collection('publications').snapshots());

  @observable
  ObservableStream<DocumentSnapshot<Map<String, dynamic>>> cartStream =
      ObservableStream(FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots());

  @action
  Future<void> addToCart(
      {required DocumentSnapshot documentSnapshot,
      required Product product}) async {
    productsInCart[documentSnapshot] = product;

    await _firestoreService.addToCart(docRef: documentSnapshot.reference);
  }

  @action
  Future<void> removeFromCart(
      {required DocumentSnapshot documentSnapshot}) async {
    productsInCart.remove(documentSnapshot);
    await _firestoreService.removeFromCart(docRef: documentSnapshot.reference);
  }

  @observable
  ObservableMap<DocumentSnapshot, Product> productsInCart =
      ObservableMap<DocumentSnapshot, Product>.of({});

  @observable
  ObservableList<DocumentSnapshot> productsFromDB = ObservableList.of([]);

  @computed
  bool get canBuy => productsInCart.isNotEmpty;

  @computed
  double get totalPrice {
    double result = 0;
    for (var element in productsInCart.values) {
      result += element.price;
    }
    return result;
  }

  @action
  Future<void> fetchCartDataFromFirestore() async {
    final firestore = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    final doc = await firestore.get();
    final cart = doc.get('cart');

    productsInCart.clear();

    for (DocumentReference docRef in cart) {
      final snapshot = await docRef.get();
      final product = Product.fromJson(snapshot.data() as Map<String, dynamic>);
      productsInCart[snapshot] = product;
    }
  }
}
