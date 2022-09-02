import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:seeds/modules/category.dart';
import 'package:seeds/modules/meal.dart';

class DioHelper {
  DioHelper._();
  static DioHelper dioHelper = DioHelper._();

  getAllCategories() async {
    List responsList = [];
    try {
      Dio dio = Dio();
      dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);

      Response response = await dio.get(
          'http://192.168.0.106/api_SeedsRestaurant/categories.php',
          // 'https://seedsrestaurant.000webhostapp.com/categories.php',
          options: buildCacheOptions(Duration(hours: 1),
              maxStale: Duration(days: 30)));
      //
      if (null != response.headers.value(DIO_CACHE_HEADER_KEY_DATA_SOURCE)) {
        print('Catching');
      } else {
        print("Network");
      }

      ///
      responsList = response.data;
      log(responsList.toString());
    } catch (e) {
      log(e.toString());
    }
    List<Category> categories = responsList.map((e) {
      return Category.fromMap(e);
    }).toList();

    return categories;
  }

  getMeals(int categoryId) async {
    List responsList = [];
    try {
      Dio dio = Dio();
      dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
      Response response = await dio.get(
          'http://192.168.0.106/api_SeedsRestaurant/meals.php?catId=$categoryId',
          options: buildCacheOptions(Duration(minutes: 8),
              maxStale: Duration(days: 1)));
      //
      if (null != response.headers.value(DIO_CACHE_HEADER_KEY_DATA_SOURCE)) {
        print('Catching');
      } else {
        print("Network");
      }

      ///
      responsList = response.data;
      log(responsList.toString());
    } catch (e) {
      log(e.toString());
    }
    List<Meal> meals = responsList.map((e) {
      return Meal.fromMap(e);
    }).toList();

    return meals;
  }

  getPopularMeals() async {
    List responsList = [];
    // try {
    Dio dio = Dio();
    // dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
    Response response = await dio.get(
      'http://192.168.0.106/api_SeedsRestaurant/popularMeals.php',
    );
    // options: buildCacheOptions(Duration(minutes: 5),
    //     maxStale: Duration(days: 3)));
    //
    // if (null != response.headers.value(DIO_CACHE_HEADER_KEY_DATA_SOURCE)) {
    //   print('Catching');
    // } else {
    //   print("Network");
    // }

    ///
    // responsList = response.data;
    log(response.toString());
    log(responsList.toString());
    // } catch (e) {
    // log(e.toString());
    // }
    List<Meal> meals = responsList.map((e) {
      return Meal.fromMap(e);
    }).toList();

    return meals;
  }
}
