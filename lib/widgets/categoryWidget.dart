import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seeds/modules/category.dart';
import 'package:seeds/seedsColors.dart';

categoryWidget(Category category) {
  return Container(
    width: 80.w,
    decoration: BoxDecoration(
      color: SeedsColors.thirdColor,
      borderRadius: BorderRadius.circular(32.r),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all((8.0).r),
          child:
              SizedBox(height: 40.h, child: Image.asset(category.imagePath!)),
        ),
        Text(
          category.title!,
          style: TextStyle(color: SeedsColors.main, fontSize: 12.sp),
        )
      ],
    ),
  );
}
