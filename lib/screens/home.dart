import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seeds/app_router.dart';
import 'package:seeds/data/Seeds_api/seed_provider.dart';
import 'package:seeds/modules/category.dart';
import 'package:seeds/modules/meal.dart';
import 'package:seeds/modules/reservation.dart';
import 'package:seeds/screens/auth/login.dart';
import 'package:seeds/screens/meals_.dart/meals.dart';
import 'package:seeds/screens/profile.dart';
import 'package:seeds/seedsColors.dart';
import 'package:seeds/widgets/categoryWidget.dart';
import 'package:seeds/widgets/mealWidget.dart';
import 'package:seeds/widgets/reservationDetails.dart';
import 'package:seeds/widgets/reservation_dialogs.dart';

import 'meals_.dart/meal_info.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SeedsProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        List<Category> categories = provider.categories;
        List<Meal> meals = provider.popularMeals;
        // provider.checkUserStatus();

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: SeedsColors.secondColor,
            toolbarHeight: kToolbarHeight + kToolbarHeight / 3.5,
            leading: IconButton(
                onPressed: () {
                  if (provider.isLoggedIn) {
                    provider.checkUserStatus();
                    AppRouter.navigateToWidget(Profile());
                  } else {
                    AppRouter.navigateToWidget(LogIn());
                  }
                },
                icon: SvgPicture.asset('assets/icons/profile.svg')),
            title: Center(
              child: Padding(
                padding: EdgeInsets.only(right: 50.w),
                child: Text(
                  'Seeds',
                  style: TextStyle(color: SeedsColors.main, fontSize: 26.sp),
                ),
              ),
            ),
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
            child: RefreshIndicator(
              onRefresh: () async {
                return await provider.refreshAll();
              },
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
                  child: categories.isNotEmpty
                      ? GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                      : Center(
                          child: SizedBox(
                          height: 200.h,
                          child:
                              Lottie.asset('assets/animation/loading_pan.json'),
                        )),
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
                  child: meals.isNotEmpty
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
                      : Center(
                          child: SizedBox(
                          height: 200.h,
                          child:
                              Lottie.asset('assets/animation/loading_pan.json'),
                        )),
                ),
                SizedBox(
                  height: 100.h,
                )
              ]),
            ),
          ),
          floatingActionButtonLocation: provider.flal,
          floatingActionButton: provider.userStatus == 2 &&
                  provider.userReservationStatus == 0
              ? InkWell(
                  onTap: () async {
                    try {
                      final result =
                          await InternetAddress.lookup('example.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        showGeneralDialog(
                          barrierLabel: '',
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: const Duration(milliseconds: 300),
                          context: context,
                          pageBuilder: (context, anim1, anim2) {
                            return ReservationDialog();
                          },
                          transitionBuilder: (context, anim1, anim2, child) {
                            return SlideTransition(
                              position: Tween(
                                      begin: const Offset(1, 0),
                                      end: const Offset(0, 0))
                                  .animate(
                                anim1,
                              ),
                              child: child,
                            );
                          },
                        );
                      } else {}
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                        content: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            'checkConnection'.tr(),
                            style: TextStyle(
                                color: SeedsColors.approved, fontSize: 24.sp),
                          ),
                        ),
                        backgroundColor: SeedsColors.active,
                        margin: EdgeInsets.symmetric(
                            vertical: 50.h, horizontal: 24.w),
                      ));
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: SeedsColors.secondMain,
                        ),
                        height: 82.h,
                        width: 280.w,
                      ),
                      SizedBox(
                        height: 100.h,
                        width: 280.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Lottie.asset('assets/animation/reserve.json',
                                width: 70.w, height: 70.h),
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
                )
              : provider.userReservationStatus == 1
                  ? ReservationDetails(
                      context,
                      provider.reservation ??
                          Reservation(
                            customerId: '',
                            guest: 0,
                            reservedDate: DateTime.now(),
                            tableId: '0',
                          ),
                      provider)
                  : const SizedBox(),
        );
      },
    );
  }
}
