import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:http_parser/http_parser.dart';

import 'package:seeds/modules/category.dart';
import 'package:seeds/modules/customer.dart';
import 'package:seeds/modules/meal.dart';
import 'package:seeds/modules/reservation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioHelper {
  DioHelper._();
  static DioHelper dioHelper = DioHelper._();

  String backEndApiLink = "https://seedsrestaurant.000webhostapp.com/";
  String localHostLink = "https://192.168.0.138/api_SeedsRestaurant/";

  addCustomer(Customer customer) async {
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({'data': customer.toMap()});

      Response<String> response = await dio.post(
        '${backEndApiLink}addCustomer.php',
        data: formData,
        options: Options(method: 'POST', headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        //
      );
      // '${backEndApiLink}categories.php');

      log(response.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  getAllCategories() async {
    List responsList = [];
    try {
      Dio dio = Dio();
      dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);

      Response response = await dio.get('${backEndApiLink}categories.php',
          // '${backEndApiLink}categories.php',
          options: buildCacheOptions(const Duration(seconds: 0),
              maxStale: const Duration(days: 30)));
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
      // dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
      Response response = await dio.get(
        '${backEndApiLink}meals.php?catId=$categoryId',
        // options: buildCacheOptions(const Duration(seconds: 0),
        //     maxStale: const Duration(days: 3))
      );
      //
      if (null != response.headers.value(DIO_CACHE_HEADER_KEY_DATA_SOURCE)) {
        print('Catching');
      } else {
        print("Network");
      }

      ///
      log('respons from get meal is: ${response.toString()}');
      if (response.data == '') {
        responsList = [];
      } else {
        responsList = response.data;
      }
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
    try {
      Dio dio = Dio();
      // dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
      Response response = await dio.get(
        '${backEndApiLink}popularMeals.php',
        // options: buildCacheOptions(const Duration(seconds: 0),
        //     maxStale: const Duration(days: 3))
      );

      // if (null != response.headers.value(DIO_CACHE_HEADER_KEY_DATA_SOURCE)) {
      //   print('Catching');
      // } else {
      //   print("Network");
      // }

      ///
      responsList = response.data;
      log('respons from popular meals');
      log(responsList.toString());
    } catch (e) {
      log(e.toString());
    }
    List<Meal> meals = responsList.map((e) {
      return Meal.fromMap(e);
    }).toList();

    return meals;
  }

  Future<String> uploadImage(File file) async {
    Dio dio = Dio();
    String fileName = file.path.split('/').last;
    log(fileName);
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType('image', 'jpg'))
    });
// await
    Response response = await dio.post("${backEndApiLink}uploadImage.php",
        data: formData,
        options: Options(method: 'POST', headers: {
          HttpHeaders.contentTypeHeader: 'multipart/form-data',
        }));
    log(response.toString());
    return response.toString();
  }

  Future<bool> checkCustomer(String phoneNumber) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '${backEndApiLink}checkCustomer.php?phoneNumber=$phoneNumber',
      );
      // log('The responst is: ${response.toString()}');

      List data;
      if (response.data == '') {
        data = [];
      } else {
        data = response.data;

        log('the phone number is: ${data.first['phone']}');
      }
      log(data.toString());
      if (data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      log('error in checkCustomer');
      return false;
    }
  }

  getCustomer(String phoneNumber) async {
    try {
      Dio dio = Dio();
      // dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
      Response response = await dio.get(
        '${backEndApiLink}checkCustomer.php?phoneNumber=$phoneNumber',
        // options: buildCacheOptions(const Duration(days: 1),
        // maxStale: const Duration(days: 3))
      );
      List data;
      if (response.data == '') {
        data = [];
      } else {
        data = response.data;
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('customer', jsonEncode(data.first));
      }
      log(data.toString());
    } catch (e) {
      log(e.toString());
      log('an error  checkCustomer');
    }
  }

  upDateCustomer(Customer customer) async {
    log('entered update');
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({'data': customer.toMap()});
      log('tried to create formDate!!');
      Response<String> response = await dio.post(
        '${backEndApiLink}updateCustomerStatus.php',
        data: formData,
        options: Options(method: 'POST', headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        //
      );
      log(customer.toMap().toString());
      // '${backEndApiLink}categories.php');
      log(response.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  submitReservationRequist(Reservation reservation, Customer customer) async {
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({'data': reservation.toMap()});

      Response<String> response = await dio.post(
        '${backEndApiLink}addReservation.php',
        data: formData,
        options: Options(method: 'POST', headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        //
      );
      // '${backEndApiLink}categories.php');

      await upDateCustomer(customer);

      log(response.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<int>> getReservedTables(DateTime dateTime) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '${backEndApiLink}reservedTables.php?time=$dateTime',
      );
      List data;
      log('respons is: $response');
      if (response.data == '') {
        data = [];
        return [];
      } else {
        data = response.data;
        log(data.toString());
        List<int> reservedTables = data.map((e) {
          return int.parse(e['table_id']);
        }).toList();
        log('$reservedTables');

        return reservedTables;
      }
    } catch (e) {
      log(e.toString());
      log('an error  getREservedtables');
      return [];
    }
  }

  getReservationDetails(String customerId) async {
    List? responsList;
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '${backEndApiLink}getReservation.php?customerId=$customerId',
      );

      if (response.data == '') {
        responsList = [];
      } else {
        responsList = response.data;
        List<Reservation> rerservation = responsList!.map((e) {
          return Reservation.fromMap(e);
        }).toList();
        log('reservations is ${rerservation.first}');
        return rerservation.first;
      }
    } catch (e) {
      log('error in getReservationDetails: ${e.toString()}');
      responsList = [];
      return ('badState');
    }
  }

  deleteReservation(String reservationId) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '${backEndApiLink}deleteReseration.php?reservationId=$reservationId',
      );

      log(response.toString());
    } catch (e) {
      log(e.toString());
      log('an error  checkCustomer');
    }
  }
}
