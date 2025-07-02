 import 'dart:convert';
import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/home/data/models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDatasource {
    Future<List<CategoryModel>> getLastCategories();
  Future<void> cacheCategories(List<CategoryModel> categories);
}


class LocalDatasourceImpl implements LocalDatasource {
  final SharedPreferences sharedPreferences;
  static const String CACHED_CATEGORIES_KEY = 'cached_categories';

  LocalDatasourceImpl(this.sharedPreferences);

  @override
  Future<List<CategoryModel>> getLastCategories() async {
    try {
      final String? categoriesJson = sharedPreferences.getString(CACHED_CATEGORIES_KEY);
      if (categoriesJson != null && categoriesJson.isNotEmpty) {
        List<dynamic> decodedList = json.decode(categoriesJson);
        return decodedList
            .map((category) => CategoryModel.fromJson(category))
            .toList();
      }
      return []; // Return empty list if no cached data
    } catch (e) {
      throw CacheFailure( 'Failed to get categories: ${e.toString()}');
    }
  }

  @override
  Future<bool> cacheCategories(List<CategoryModel> categories) async {
    try {
      final categoriesJson = json.encode(
        categories.map((category) => category.toJson()).toList(),
      );
      return await sharedPreferences.setString(CACHED_CATEGORIES_KEY, categoriesJson);
    } catch (e) {
      throw CacheFailure('Failed to cache categories: ${e.toString()}');
    }
  }

  // Add method to check if cache exists and is valid
  Future<bool> hasCachedData() async {
    final String? categoriesJson = sharedPreferences.getString(CACHED_CATEGORIES_KEY);
    return categoriesJson != null && categoriesJson.isNotEmpty;
  }
}