// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
import 'package:test_store_app/data/repositories/store_repository.dart';
import 'package:test_store_app/domain/models/all_categories_response.dart';

part 'store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  final StoreRepository _storeRepo = StoreRepositoryImpl();

  @observable
  ObservableList<String> categories = ObservableList<String>.of([]);

  @action
  Future<void> getCategories() async {
    AllCategoriesResponse allCategoriesResponse =
        await _storeRepo.getAllCategories();
    categories.clear();
    for (String element in allCategoriesResponse.categories ?? []) {
      categories.add(element);
    }
  }
}
