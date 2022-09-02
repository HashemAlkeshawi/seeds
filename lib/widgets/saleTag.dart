import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seeds/seedsColors.dart';

saleTag(int price) {
  return Stack(
    children: [
      SvgPicture.asset('assets/icons/saleTag.svg'),
      Padding(
        padding: EdgeInsets.only(left: 20.w, top: 3.h),
        child: Text(
          price.toString(),
          style: TextStyle(fontSize: 13.sp),
        ),
      )
    ],
  );
}

priceTag(int price) {
  return SizedBox(
    width: 50.w,
    child: Row(
      children: [
        Text(
          ' ${price.toString()} ',
          style: TextStyle(fontSize: 13, color: SeedsColors.main),
        ),
        SvgPicture.asset(
          'assets/icons/shaikel.svg',
        ),
      ],
    ),
  );
}
