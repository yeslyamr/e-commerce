// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'list_categories_store.g.dart';

class ListCategoriesStore = _ListCategoriesStore with _$ListCategoriesStore;

abstract class _ListCategoriesStore with Store {
  // @observable
  // QueryDocumentSnapshot? lastVis;

  // @action
  // Future<List<Product>> getProducts() async {
  //   List<Product> result = [];

  //   final first = _firestoreService.getPublicationsFromFirestore(lastVis);
  //   final docs = (await first.get()).docs;

  //   for (var pr in docs) {

  //     result.add(Product.fromJson(pr.data()));
  //   }
  //   lastVis = docs[docs.length - 1];
  //   return result;
  // }
}
