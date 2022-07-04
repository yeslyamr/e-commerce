import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CloudFirestoreService {
  Future<void> postPublication() async {
    final firestore =
        FirebaseFirestore.instance.collection('publications').doc('qwer');
  }

  Future<void> deletePublication() async {}

  Future<void> getAllPublication() async {}

  Future<void> addToCart() async {}

  Future<void> purchase() async {}
}

class CloudFirestoreServiceImpl implements CloudFirestoreService {
  @override
  Future<void> deletePublication() {
    // TODO: implement deletePublication
    throw UnimplementedError();
  }

  @override
  Future<void> postPublication() {
    // TODO: implement postPublication
    throw UnimplementedError();
  }

  @override
  Future<void> getAllPublication() {
    // TODO: implement getAllPublication
    throw UnimplementedError();
  }

  @override
  Future<void> addToCart() {
    // TODO: implement addToCart
    throw UnimplementedError();
  }

  @override
  Future<void> purchase() {
    // TODO: implement purchase
    throw UnimplementedError();
  }
}
