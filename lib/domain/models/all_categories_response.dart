// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'all_categories_response.g.dart';

@JsonSerializable()
class AllCategoriesResponse {
  List<String>? categories;

  AllCategoriesResponse({
    this.categories,
  });

  factory AllCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$AllCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllCategoriesResponseToJson(this);

  @override
  String toString() => 'AllCategoriesResponse(categories: $categories)';
}
