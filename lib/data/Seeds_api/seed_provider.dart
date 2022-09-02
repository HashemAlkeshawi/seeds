import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:seeds/data/Seeds_api/dio_helper.dart';
import 'package:seeds/modules/category.dart';
import 'package:seeds/modules/meal.dart';

class SeedsProvider extends ChangeNotifier {
  SeedsProvider() {
    getAllCategories();
    getPopularMeals();
  }
  List<Category> categories = [];
  List<Meal> meals = [];
  List<Meal> popularMeals = [];

  getAllCategories() async {
    categories = await DioHelper.dioHelper.getAllCategories();
    notifyListeners();
  }

  getMeals(int categoryId) async {
    meals = await DioHelper.dioHelper.getMeals(categoryId);
    notifyListeners();
  }

  getPopularMeals() async {
    popularMeals = await DioHelper.dioHelper.getPopularMeals();
    notifyListeners();
  }
}
