import 'package:test_store_app/data/gateways/api_constants.dart';
import 'package:test_store_app/data/gateways/network_client.dart';
import 'package:test_store_app/domain/models/all_categories_response.dart';
import 'package:test_store_app/domain/models/product.dart';
import 'package:test_store_app/domain/models/products_in_category_response.dart';

abstract class StoreRepository {
  Future<AllCategoriesResponse> getAllCategories();

  Future<ProductsInCategoryResponse> getProductsInCategory(
      {required String category});

  Future<Product> getSingleProduct({required String productId});
}

class StoreRepositoryImpl implements StoreRepository {
  final _client = NetworkClient();

  @override
  Future<AllCategoriesResponse> getAllCategories() async {
    try {
      return await _client.get(
          path: ApiConstants.getAllCategories,
          parser: (dynamic json) {
            List<String> res = [];
            for (String element in json) {
              res.add(element);
            }
            return AllCategoriesResponse(categories: res);
          });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsInCategoryResponse> getProductsInCategory(
      {required String category}) async {
    try {
      return await _client.get(
          path: 'products/category/$category',
          parser: (dynamic json) {
            List<Product> res = [];
            for (var element in json) {
              res.add(Product.fromJson(element));
            }
            return ProductsInCategoryResponse(products: res);
          });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Product> getSingleProduct({required String productId}) async {
    try {
      return await _client.get(
          path: 'products/$productId',
          parser: (dynamic json) {
            return Product.fromJson(json);
          });
    } catch (e) {
      rethrow;
    }
  }
}
