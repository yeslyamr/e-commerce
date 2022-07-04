// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:test_store_app/domain/models/product.dart';

class ProductsInCategoryResponse {
  List<Product>? products;
  ProductsInCategoryResponse({
    this.products,
  });

  @override
  String toString() => 'ProductsInCategoryResponse(products: $products)';
}
