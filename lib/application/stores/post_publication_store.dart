// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:test_store_app/domain/models/product.dart';
import 'package:test_store_app/domain/services/firestore_service.dart';

part 'post_publication_store.g.dart';

class PostPublStore = _PostPublStore with _$PostPublStore;

abstract class _PostPublStore with Store {
  final _firestoreService = CloudFirestoreServiceImpl();

  @observable
  String title = '';
  @observable
  double price = 0;

  @computed
  bool get canPost => title.isNotEmpty && price > 0;

  Future<void> test() async {
    // final pr = await _firestoreService.getMyPublications();
    // print(pr);
  }

  @action
  Future<void> postRandom() async {
    var product = Product(
        title:
            '${FirebaseAuth.instance.currentUser?.displayName} ${Random().nextInt(50)}',
        price: Random().nextDouble());
    await _firestoreService.postPublication(product: product);
    product = Product(
        title:
            '${FirebaseAuth.instance.currentUser?.displayName} ${Random().nextInt(50)}',
        price: Random().nextDouble());
    await _firestoreService.postPublication(product: product);
    product = Product(
        title:
            '${FirebaseAuth.instance.currentUser?.displayName} ${Random().nextInt(50)}',
        price: Random().nextDouble());
    await _firestoreService.postPublication(product: product);
  }

  @action
  Future<void> post() async {
    final product = Product(title: title, price: price);
    title = '';
    price = 0;
    await _firestoreService.postPublication(product: product);
  }
}
