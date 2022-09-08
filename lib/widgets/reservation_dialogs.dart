import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seeds/app_router.dart';
import 'package:seeds/data/Seeds_api/seed_provider.dart';

import 'package:flutter/material.dart';
import 'package:seeds/seedsColors.dart';
import 'package:seeds/widgets/reservatoin_dialog_tables.dart';

class ReservationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> titleKey = GlobalKey<FormState>();
    return Consumer<SeedsProvider>(
      builder: (BuildContext context, provider, child) {
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
                height: 285.h,
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
                    SizedBox(
                      width: 295.w,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "numberOfGuests".tr(),
                            style: TextStyle(
                                color: SeedsColors.freeStar, fontSize: 14.sp),
                          ),
                          SizedBox(width: 10.w),
                          Container(
                              decoration: BoxDecoration(
                                  color: SeedsColors.thirdColor,
                                  borderRadius: BorderRadius.circular(20.r)),
                              width: 62.w,
                              height: 37.h,
                              child: Center(
                                child: SizedBox(
                                  // width: 12.w,
                                  child: Text(
                                    provider.numberOfGuests.toString(),
                                    style: TextStyle(
                                        color: SeedsColors.main,
                                        fontSize: 16.sp),
                                  ),
                                ),
                              )),
                          IconButton(
                            iconSize: 40.r,
                            onPressed: () {
                              provider.addGuest();
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/addCircle.svg',
                            ),
                          ),
                          IconButton(
                            iconSize: 40.r,
                            onPressed: () {
                              log('delte guest');
                              provider.deleteGuest();
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/subCircle.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: 295.w,
                      child: Row(
                        children: [
                          Text(
                            "reservationDate".tr(),
                            style: TextStyle(
                                color: SeedsColors.freeStar, fontSize: 14.sp),
                          ),
                          SizedBox(width: 18.w),
                          InkWell(
                            onTap: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime.now()
                                      .add(const Duration(days: 60)),
                                  onConfirm: (date) {
                                provider.setReservationDate(date);
                              },
                                  currentTime: DateTime.now(),
                                  locale: EasyLocalization.of(context)!
                                              .currentLocale ==
                                          Locale('ar')
                                      ? LocaleType.ar
                                      : LocaleType.en);
                            },
                            child: Container(
                                // padding: EdgeInsets.all(12.r),
                                decoration: BoxDecoration(
                                    color: SeedsColors.thirdColor,
                                    borderRadius: BorderRadius.circular(17.r)),
                                width: 120.w,
                                height: 45.h,
                                child: Center(
                                  child: Text(
                                    provider.reservationDate == null
                                        ? "selectDate".tr()
                                        : DateFormat('dd, MMM hh:mm a')
                                            .format(provider.reservationDate!)
                                            .toLocale()
                                            .toString(),
                                    // '26, SEP 15:30',
                                    style: TextStyle(
                                        color: SeedsColors.main,
                                        fontSize: 14.sp),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        if (provider.reservationDate != null) {
                          log('tapped on second');
                          showGeneralDialog(
                            anchorPoint: Offset(0, 0),
                            barrierLabel: '',
                            barrierDismissible: true,
                            barrierColor: Colors.black.withOpacity(0.5),
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            context: context,
                            pageBuilder: (context, anim1, anim2) {
                              return ReservationDialogTables();
                            },
                            transitionBuilder: (context, anim1, anim2, child) {
                              return SlideTransition(
                                position: Tween(
                                        begin: const Offset(2, 0),
                                        end: const Offset(0, 0))
                                    .animate(
                                  anim1,
                                ),
                                child: child,
                              );
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('selectDate'.tr()),
                          ));
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: SeedsColors.main,
                              borderRadius: BorderRadius.circular(26.r)),
                          width: 343.w,
                          height: 55.h,
                          child: Center(
                            child: Text(
                              "continue".tr(),
                              // '26, SEP 15:30',
                              style: TextStyle(
                                  color: SeedsColors.offWhite, fontSize: 24.sp),
                            ),
                          )),
                    ),
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
