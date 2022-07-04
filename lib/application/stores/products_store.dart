// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
import 'package:test_store_app/data/repositories/store_repository.dart';
import 'package:test_store_app/domain/models/product.dart';
import 'package:test_store_app/domain/models/products_in_category_response.dart';

part 'products_store.g.dart';

class ProductsStore = _ProductsStore with _$ProductsStore;

abstract class _ProductsStore with Store {
  final StoreRepository _storeRepo = StoreRepositoryImpl();

  @observable
  ObservableList<Product> products = ObservableList<Product>.of([]);

  @action
  Future<void> getProducts({required String category}) async {
    ProductsInCategoryResponse productsInCategoryResponse =
        await _storeRepo.getProductsInCategory(category: category);
    products.clear();
    for (var element in productsInCategoryResponse.products ?? []) {
      products.add(element);
    }
  }
}
