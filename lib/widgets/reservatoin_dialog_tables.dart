import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seeds/app_router.dart';
import 'package:seeds/data/Seeds_api/seed_provider.dart';

import 'package:flutter/material.dart';
import 'package:seeds/seedsColors.dart';

class ReservationDialogTables extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> titleKey = GlobalKey<FormState>();
    return Consumer<SeedsProvider>(
      builder: (BuildContext context, provider, child) {
        int selectedTable = provider.selectedTable ?? 0;
        return Center(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                padding: EdgeInsets.only(top: 20.h),
                decoration: BoxDecoration(
                  color: SeedsColors.secondColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                height: 565.h,
                width: 343.w,
                child: Column(
                  children: [
                    Text(
                      'reservationDetails'.tr(),
                      style:
                          TextStyle(color: SeedsColors.main, fontSize: 22.sp),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: SizedBox(
                            height: 425.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  //No. 1
                                  height: 90.h,
                                  width: 108.w,
                                  child: IconButton(
                                      onPressed: () {
                                        !provider.isReserved(1)
                                            ? provider.selectTable(1)
                                            : {};
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/images/tables/t4.svg',
                                        fit: BoxFit.fill,
                                        color: provider.isReserved(1)
                                            ? SeedsColors.secondMain
                                            : selectedTable == 1
                                                ? SeedsColors.active
                                                : SeedsColors.offWhite,
                                      )),
                                ),
                                SizedBox(
                                  //No.2
                                  height: 108.h,
                                  width: 170.w,
                                  child: IconButton(
                                      onPressed: () {
                                        !provider.isReserved(2)
                                            ? provider.selectTable(2)
                                            : {};
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/images/tables/t8.svg',
                                        fit: BoxFit.fill,
                                        color: provider.isReserved(2)
                                            ? SeedsColors.secondMain
                                            : selectedTable == 2
                                                ? SeedsColors.active
                                                : SeedsColors.offWhite,
                                      )),
                                ),
                                SizedBox(
                                  //No.3
                                  height: 54.h,
                                  width: 108.w,
                                  child: IconButton(
                                      onPressed: () {
                                        !provider.isReserved(3)
                                            ? provider.selectTable(3)
                                            : {};
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/images/tables/t2.svg',
                                        fit: BoxFit.fill,
                                        color: provider.isReserved(3)
                                            ? SeedsColors.secondMain
                                            : selectedTable == 3
                                                ? SeedsColors.active
                                                : SeedsColors.offWhite,
                                      )),
                                ),
                                SizedBox(
                                  height: 110.h,
                                  width: 108.w,
                                  child: Tooltip(
                                      triggerMode: TooltipTriggerMode.tap,
                                      textStyle: TextStyle(
                                          color: SeedsColors.offWhite),
                                      message: 'Directions'.tr(),
                                      child: Image.asset(
                                        'assets/images/north.png',
                                        fit: BoxFit.fill,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: SizedBox(
                            height: 425.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  //No.4
                                  height: 90.h,
                                  width: 108.w,
                                  child: IconButton(
                                      onPressed: () {
                                        !provider.isReserved(4)
                                            ? provider.selectTable(4)
                                            : {};
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/images/tables/t4.svg',
                                        fit: BoxFit.fill,
                                        color: provider.isReserved(4)
                                            ? SeedsColors.secondMain
                                            : selectedTable == 4
                                                ? SeedsColors.active
                                                : SeedsColors.offWhite,
                                      )),
                                ),
                                SizedBox(
                                  //No.5
                                  height: 90.h,
                                  width: 108.w,
                                  child: IconButton(
                                      onPressed: () {
                                        !provider.isReserved(5)
                                            ? provider.selectTable(5)
                                            : {};
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/images/tables/t4.svg',
                                        fit: BoxFit.fill,
                                        color: provider.isReserved(5)
                                            ? SeedsColors.secondMain
                                            : selectedTable == 5
                                                ? SeedsColors.active
                                                : SeedsColors.offWhite,
                                      )),
                                ),
                                SizedBox(
                                  //No.6
                                  height: 90.h,
                                  width: 108.w,
                                  child: IconButton(
                                      onPressed: () {
                                        !provider.isReserved(6)
                                            ? provider.selectTable(6)
                                            : {};
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/images/tables/t4.svg',
                                        fit: BoxFit.fill,
                                        color: provider.isReserved(6)
                                            ? SeedsColors.secondMain
                                            : selectedTable == 6
                                                ? SeedsColors.active
                                                : SeedsColors.offWhite,
                                      )),
                                ),
                                SizedBox(
                                  //No.7
                                  height: 140.h,
                                  width: 140.w,
                                  child: IconButton(
                                      onPressed: () {
                                        !provider.isReserved(7)
                                            ? provider.selectTable(7)
                                            : {};
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/images/tables/t7.svg',
                                        fit: BoxFit.fill,
                                        color: provider.isReserved(7)
                                            ? SeedsColors.secondMain
                                            : selectedTable == 7
                                                ? SeedsColors.active
                                                : SeedsColors.offWhite,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: InkWell(
                            onTap: () {
                              AppRouter.popFromWidget();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: SeedsColors.main.withAlpha(150),
                                    borderRadius: const Locale('ar') ==
                                            EasyLocalization.of(context)!
                                                .currentLocale
                                        ? BorderRadius.horizontal(
                                            right: Radius.circular(26.r))
                                        : BorderRadius.horizontal(
                                            left: Radius.circular(26.r))),
                                // width: 343.w,
                                height: 55.h,
                                child: Center(
                                  child: Text(
                                    "back".tr(),
                                    // '26, SEP 15:30',
                                    style: TextStyle(
                                        color: SeedsColors.offWhite,
                                        fontSize: 24.sp),
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: InkWell(
                            onTap: () async {
                              if (provider.selectedTable != null) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 100.h,
                                        width: 100.h,
                                        child: Lottie.asset(
                                            'assets/animation/loading.json'),
                                      );
                                    });
                                await provider.submitReservationRequist();
                                provider.resetReservationState();
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                AppRouter.popFromWidget();
                                AppRouter.popFromWidget();
                                await Future.delayed(
                                    const Duration(milliseconds: 400));
                                AppRouter.popFromWidget();

                                provider.userReservationStatus == 1
                                    ? {}
                                    : {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: const Duration(seconds: 3),
                                          behavior: SnackBarBehavior.floating,
                                          content: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: Text(
                                              'errorINRequist'.tr(),
                                              style: TextStyle(
                                                  color:
                                                      SeedsColors.secondColor,
                                                  fontSize: 24.sp),
                                            ),
                                          ),
                                          backgroundColor:
                                              SeedsColors.secondMain,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 50.h, horizontal: 24.w),
                                        ))
                                      };
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('selectTable'.tr()),
                                  // margin: EdgeInsets.symmetric(
                                  //     vertical: 20.h, horizontal: 24.w),
                                ));
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: SeedsColors.main,
                                    borderRadius: const Locale('ar') ==
                                            EasyLocalization.of(context)!
                                                .currentLocale
                                        ? BorderRadius.horizontal(
                                            left: Radius.circular(26.r))
                                        : BorderRadius.horizontal(
                                            right: Radius.circular(26.r))),
                                // width: 343.w,
                                height: 55.h,
                                child: Center(
                                  child: Text(
                                    "reserve".tr(),
                                    // '26, SEP 15:30',
                                    style: TextStyle(
                                        color: SeedsColors.offWhite,
                                        fontSize: 24.sp),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
