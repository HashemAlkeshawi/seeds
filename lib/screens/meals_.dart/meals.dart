import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seeds/data/Seeds_api/seed_provider.dart';
import 'package:seeds/modules/category.dart';
import 'package:seeds/modules/meal.dart';
import 'package:seeds/screens/meals_.dart/meal_info.dart';
import 'package:seeds/seedsColors.dart';
import 'package:seeds/widgets/appBar.dart';
import 'package:seeds/widgets/mealWidget.dart';

class Meals extends StatelessWidget {
  Category category;
  Meals(this.category);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SeedsColors.secondColor,
      appBar: appBar(category.title!),
      body: Consumer<SeedsProvider>(
        builder: (BuildContext context, provider, child) {
          List<Meal> meals = provider.meals;
          return provider.meals.isEmpty
              ? Center(
                  child: SizedBox(
                      height: 150.h,
                      child: SvgPicture.asset(
                          'assets/animation/loading_pan.json',
                          color: SeedsColors.main)),
                )
              : Container(
                  color: SeedsColors.secondColor,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                    ),
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return mealInfo(meals[index]);
                              },
                              context: context);
                        },
                        child: mealWidget(
                          meals[index],
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
