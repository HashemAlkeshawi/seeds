import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:seeds/app_router.dart';
import 'package:seeds/data/Seeds_api/seed_provider.dart';
import 'package:seeds/modules/reservation.dart';

import '../seedsColors.dart';

ReservationDetails(
    BuildContext context, Reservation reservation, SeedsProvider provider) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 4.r),
    height: 90.h,
    width: 375.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      color: SeedsColors.thirdColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, -3), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/reservationDetails/reservationDish.svg',
                  width: 20.w,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    'yourRequist'.tr(),
                    style: TextStyle(color: SeedsColors.main, fontSize: 17),
                  ),
                )
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/reservationDetails/guests.svg',
                  width: 20.w,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    'people'.plural(reservation.guest),
                    style: TextStyle(color: SeedsColors.freeStar, fontSize: 14),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/reservationDetails/table.svg',
                  width: 20.w,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    'tableNo_'.plural(int.parse(reservation.tableId)),
                    style: TextStyle(color: SeedsColors.freeStar, fontSize: 14),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/reservationDetails/calendar.svg',
                  width: 20.w,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    DateFormat('dd, MMM hh:mm a')
                        .format(reservation.reservedDate)
                        .toLocale()
                        .toString(),
                    style: TextStyle(color: SeedsColors.freeStar, fontSize: 14),
                  ),
                )
              ],
            ),
          ],
        ),
        reservation.reservationStatus == 0
            ? Text(
                'pending'.tr(),
                style: TextStyle(color: SeedsColors.main, fontSize: 14.sp),
              )
            : Text(
                'approved'.tr(),
                style: TextStyle(color: SeedsColors.approved, fontSize: 16.sp),
              ),
        reservation.reservationStatus == 0
            ? InkWell(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            backgroundColor: SeedsColors.secondColor,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  AppRouter.popFromWidget();
                                },
                                child: Text(
                                  'cancel'.tr(),
                                  style: TextStyle(color: SeedsColors.main),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  AppRouter.popFromWidget();
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
                                  await provider
                                      .deleteReservation(reservation.id!);
                                  await Future.delayed(
                                      const Duration(milliseconds: 1600));
                                  AppRouter.popFromWidget();
                                },
                                child: Text(
                                  'delete'.tr(),
                                  style:
                                      TextStyle(color: SeedsColors.secondMain),
                                ),
                              ),
                            ],
                            title: Text(
                              'deleteRequist'.tr(),
                              style: TextStyle(
                                  color: SeedsColors.secondMain,
                                  fontSize: 24.sp),
                            ),
                            content: Text(
                              'deleteRequistContent'.tr(),
                              style: TextStyle(
                                  color: SeedsColors.freeStar, fontSize: 20.sp),
                            ),
                          ));
                },
                child: Container(
                  width: 60.w,
                  height: 62.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: SeedsColors.secondMain,
                  ),
                  child: Icon(
                    Icons.delete,
                    size: 35.r,
                    color: SeedsColors.freeStar,
                  ),
                ),
              )
            : const SizedBox()
      ],
    ),
  );
}
