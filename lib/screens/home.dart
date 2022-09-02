import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seeds/app_router.dart';
import 'package:seeds/data/Seeds_api/seed_provider.dart';
import 'package:seeds/data/firebase/firebase_helper.dart';
import 'package:seeds/data/firebase/firebase_provider.dart';
import 'package:seeds/modules/category.dart';
import 'package:seeds/modules/meal.dart';
import 'package:seeds/screens/meals_.dart/meals.dart';
import 'package:seeds/screens/profile.dart';
import 'package:seeds/seedsColors.dart';
import 'package:seeds/widgets/categoryWidget.dart';
import 'package:seeds/widgets/mealWidget.dart';

import 'meals_.dart/mealInfo.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Firebase_Helper.firebase_helper.verifyPhoneNumber();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: SeedsColors.secondColor,
        toolbarHeight: kToolbarHeight + kToolbarHeight / 3.5,
        leading: IconButton(
            onPressed: () {
              AppRouter.navigateToWidget(Profile());
            },
            icon: SvgPicture.asset('assets/icons/profile.svg')),
        title: Center(
          child: Text(
            'Seeds',
            style: TextStyle(color: SeedsColors.main, fontSize: 26.sp),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/heart.svg'),
          ),
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Center(
              child: SvgPicture.asset('assets/icons/curveSeeds.svg'),
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: SeedsColors.secondColor,
        ),
        child: ListView(physics: BouncingScrollPhysics(), children: [
          SizedBox(
            child: SvgPicture.asset(
              'assets/images/restaurant.svg',
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 30.h, bottom: 15.h, left: 12.w, right: 12.w),
            child: Text(
              'categoris'.tr(),
              style: TextStyle(
                color: SeedsColors.offWhite,
                fontSize: 18.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Consumer<SeedsProvider>(
              builder: (BuildContext context, provider, child) {
                List<Category> categories = provider.categories;
                return categories.isNotEmpty
                    ? GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 6.w,
                          mainAxisSpacing: 6.h,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              provider.meals = [];
                              provider.getMeals(categories[index].id!);
                              AppRouter.navigateToWidget(
                                  Meals(categories[index]));
                            },
                            child: categoryWidget(
                              categories[index],
                            ),
                          );
                        },
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        child: const Center(child: CircularProgressIndicator()),
                      );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 30.h, bottom: 15.h, left: 12.w, right: 12.w),
            child: Text(
              'popularDished'.tr(),
              style: TextStyle(
                color: SeedsColors.offWhite,
                fontSize: 18.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Consumer<SeedsProvider>(
              builder: (BuildContext context, provider, child) {
                List<Meal> meals = provider.popularMeals;
                return meals.isNotEmpty
                    ? SizedBox(
                        height: 116,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
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
                              child: popularMealWidget(
                                meals[index],
                              ),
                            );
                          },
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        child: const Center(child: CircularProgressIndicator()),
                      );
              },
            ),
          ),
          SizedBox(
            height: 100.h,
          )
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () {
          log('tapped');
        },
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: SeedsColors.secondMain,
              ),
              height: 78.h,
              width: 280.w,
            ),
            SizedBox(
              height: 90.h,
              width: 280.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Lottie.asset('assets/animation/reserve.json',
                      width: 60.w, height: 60.h),
                  Text(
                    'reserveTable'.tr(),
                    style: TextStyle(
                      color: SeedsColors.offWhite,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Category category =
      Category(id: 1, title: 'Vegetables', imagePath: 'assets/icons/meat.svg');
}
