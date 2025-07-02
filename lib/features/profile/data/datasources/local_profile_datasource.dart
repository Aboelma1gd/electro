import 'dart:convert';

import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/profile/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalProfileDatasource {
  Future<UserModel?> getlocalProfile();
  Future<void> cacheprofile(UserModel profile);
}

class LocalProfileDatasourceImpl implements LocalProfileDatasource {
  final SharedPreferences sharedPreferences;
  static const String CACHED_Profile_KEY = 'CACHED_Profile_KEY';

  LocalProfileDatasourceImpl(this.sharedPreferences);

 @override
Future<UserModel?> getlocalProfile() async {
  try {
    final String? profileJson = sharedPreferences.getString(CACHED_Profile_KEY);
    
    // If no data exists, return null instead of throwing an error
    if (profileJson == null || profileJson.isEmpty) {
      return null;
    }
    
    try {
      final dynamic decodedData = json.decode(profileJson);
      
      if (decodedData is Map<String, dynamic>) {
        return UserModel.fromJson(decodedData);
      } else if (decodedData is List && decodedData.isNotEmpty) {
        if (decodedData.first is Map<String, dynamic>) {
          return UserModel.fromJson(Map<String, dynamic>.from(decodedData.first));
        }
      }
      
      // Invalid format but don't throw - just clear the cache and return null
      print("Invalid data format in cache, clearing cache");
      await sharedPreferences.remove(CACHED_Profile_KEY);
      return null;
      
    } catch (decodeError) {
      // JSON decode failed - clear invalid cache
      print("Failed to decode cache data, clearing cache: $decodeError");
      await sharedPreferences.remove(CACHED_Profile_KEY);
      return null;
    }
  } catch (e) {
    // Only throw for actual SharedPreferences errors
    throw CacheFailure('Failed to access SharedPreferences: ${e.toString()}');
  }
}
  @override
Future<bool> cacheprofile(UserModel profile) async {
  try {
    // Ensure we're caching a Map and not a List
    final profileJson = json.encode(profile.toJson());
    return await sharedPreferences.setString(CACHED_Profile_KEY, profileJson);
  } catch (e) {
    throw CacheFailure('Failed to cache profile: ${e.toString()}');
  }
}
}





