// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:test_store_app/domain/models/product.dart';
import 'package:test_store_app/domain/services/firestore_service.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  final _firestoreService = CloudFirestoreServiceImpl();

  @observable
  ObservableMap<DocumentReference, Product> myPublications =
      ObservableMap<DocumentReference, Product>.of({});

  @action
  Future<void> deletePublication({required DocumentReference docRef}) async {
    myPublications.remove(docRef);

    await _firestoreService.deletePublication(docRef: docRef);
  }

  @action
  void deleteAllPublication() {
    final copy = Map.from(myPublications);
    myPublications.clear();
    for (var entry in copy.entries) {
      _firestoreService.deletePublication(docRef: entry.key);
    }
  }

  @action
  Future<void> fetchMyPublications() async {
    final listDocRefMyPubl = await _firestoreService.getMyPublications();
    myPublications.clear();
    for (DocumentReference docRef in listDocRefMyPubl) {
      final q = (await docRef.get()).data();
      if (q != null) {
        myPublications[docRef] = Product.fromJson(q as Map<String, dynamic>);
      }
    }
  }
}
