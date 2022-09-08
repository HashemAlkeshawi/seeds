import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seeds/seedsColors.dart';
import 'package:seeds/widgets/saleTag.dart';

import '../../modules/meal.dart';

mealInfo(Meal meal) {
  return Container(
    padding: EdgeInsets.only(top: 6.h),
    height: 570.h,
    decoration: BoxDecoration(
      color: SeedsColors.secondColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50.r),
        topRight: Radius.circular(50.r),
      ),
    ),
    child: ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 275.h,
          width: 270.w,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 18.r),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: Image.network(
                meal.imagePath!,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              meal.title!,
              style: TextStyle(fontSize: 16.sp, color: SeedsColors.freeStar),
            ),
          ),
          trailing: SizedBox(
            width: 122.w,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              meal.hasSale ? saleTag(meal.salePrice ?? 0) : const SizedBox(),
              SizedBox(
                width: 5.w,
              ),
              priceTag(meal.price ?? 0),
            ]),
          ),
          subtitle: RatingBar.builder(
            itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
            itemSize: 18.r,
            initialRating: meal.rating ?? 2,
            allowHalfRating: true,
            itemBuilder: ((context, index) =>
                Icon(Icons.star, color: SeedsColors.secondMain)),
            onRatingUpdate: (rating) {
              log(rating.toString());
            },
          ),
        ),
        meal.hasSale
            ? Padding(
                padding: EdgeInsets.only(left: 12.w, bottom: 12.h),
                child: Row(
                  children: [
                    Text(
                      'saleDays'.tr(),
                      style: TextStyle(
                          color: SeedsColors.goldenTextColor, fontSize: 14.sp),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      (meal.saleDays ?? "-${'noSale'.tr()}-").substring(1,
                          (meal.saleDays ?? "-${'noSale'.tr()}-").length - 1),
                      style: TextStyle(
                          color: SeedsColors.offWhite, fontSize: 14.sp),
                    )
                  ],
                ),
              )
            : const SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            meal.descreption ?? 'The meal: ${meal.title}',
            style: TextStyle(
                fontSize: 14.sp, color: SeedsColors.freeStar.withAlpha(180)),
          ),
        ),
      ],
    ),
  );
}
