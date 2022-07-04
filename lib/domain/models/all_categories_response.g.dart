// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCategoriesResponse _$AllCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    AllCategoriesResponse(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AllCategoriesResponseToJson(
        AllCategoriesResponse instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };
