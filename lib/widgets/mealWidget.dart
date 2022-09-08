import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seeds/modules/meal.dart';
import 'package:seeds/seedsColors.dart';

popularMealWidget(Meal meal) {
  return Stack(
    children: [
      Container(
        margin: EdgeInsets.only(right: 20.w),
        width: 124.w,
        height: 145.h,
        decoration: BoxDecoration(
          color: SeedsColors.thirdColor,
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80.h,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 6.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    meal.imagePath!,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              meal.title!,
              style: TextStyle(color: SeedsColors.freeStar, fontSize: 12.sp),
            ),
            RatingBar.builder(
                itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                itemSize: 19.r,
                initialRating: meal.rating ?? 2,
                allowHalfRating: true,
                itemBuilder: ((context, index) =>
                    Icon(Icons.star, color: SeedsColors.main)),
                onRatingUpdate: (rating) {
                  log(rating.toString());
                })
          ],
        ),
      ),
      meal.hasSale
          ? Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: SizedBox(
                height: 10.h,
                width: 145.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset('assets/icons/saleTag.svg'),
                  ],
                ),
              ),
            )
          : SizedBox()
    ],
  );
}

mealWidget(Meal meal) {
  return Stack(
    children: [
      Container(
        width: 166.w,
        height: 190.h,
        decoration: BoxDecoration(
          color: SeedsColors.thirdColor,
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 110.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    meal.imagePath!,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              meal.title!,
              style: TextStyle(color: SeedsColors.freeStar, fontSize: 15.sp),
            ),
            RatingBar.builder(
                itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                itemSize: 22.r,
                initialRating: meal.rating ?? 2,
                allowHalfRating: true,
                itemBuilder: ((context, index) =>
                    Icon(Icons.star, color: SeedsColors.main)),
                onRatingUpdate: (rating) {
                  log(rating.toString());
                })
          ],
        ),
      ),
      meal.hasSale
          ? Container(
              margin: EdgeInsets.only(top: 15.h),
              height: 12.h,
              child: SvgPicture.asset('assets/icons/saleTag.svg'),
            )
          : SizedBox()
    ],
  );
}
