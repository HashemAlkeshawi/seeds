import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          height: 180.h,
          width: 340.w,
          child: Image.asset(
            meal.imagePath!,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {
              log('nothign');
            },
            child: SizedBox(
              child: SvgPicture.asset(
                'assets/icons/favorated.svg',
                width: 90.w,
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
            itemSize: 22.r,
            initialRating: meal.rating ?? 2,
            allowHalfRating: true,
            itemBuilder: ((context, index) =>
                Icon(Icons.star, color: SeedsColors.main)),
            onRatingUpdate: (rating) {
              log(rating.toString());
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            meal.descreption ?? 'The meal: ${meal.title}',
            style: TextStyle(fontSize: 14.sp, color: SeedsColors.freeStar),
          ),
        ),
      ],
    ),
  );
}
