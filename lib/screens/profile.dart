import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seeds/seedsColors.dart';
import 'package:seeds/widgets/appBar.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('profile'.tr()),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        decoration: BoxDecoration(color: SeedsColors.secondColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 115.h,
                  width: 115.w,
                  margin: EdgeInsets.all(40.r),
                  child: CircleAvatar(
                    child: Image.asset(
                      'assets/images/user.png',
                      fit: BoxFit.cover,
                      height: 115.h,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'name'.tr(),
                      style: TextStyle(
                          color: SeedsColors.freeStar, fontSize: 14.sp),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Hashem Alekshawi',
                            style: TextStyle(
                                color: SeedsColors.goldenTextColor,
                                fontSize: 21.sp),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.edit,
                          color: SeedsColors.goldenTextColor,
                        )
                      ],
                    )
                  ]),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'phone'.tr(),
                      style: TextStyle(
                          color: SeedsColors.freeStar, fontSize: 14.sp),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            '+970592103756',
                            style: TextStyle(
                                color: SeedsColors.goldenTextColor,
                                fontSize: 21.sp),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.edit,
                          color: SeedsColors.goldenTextColor,
                        )
                      ],
                    )
                  ]),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    child: Text(
                      'ActivationLabel',
                      style: TextStyle(
                          color: SeedsColors.freeStar, fontSize: 14.sp),
                    ),
                  ),
                  Text(
                    'inactive'.tr(),
                    style:
                        TextStyle(color: SeedsColors.inactive, fontSize: 14.sp),
                  ),
                  Icon(
                    Icons.info_outline,
                    color: SeedsColors.freeStar,
                  )
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 155.w,
                      height: 55.h,
                      decoration: BoxDecoration(
                        color: SeedsColors.active,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'activate'.tr(),
                          style: TextStyle(
                              color: SeedsColors.secondColor, fontSize: 12.sp),
                        ),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
