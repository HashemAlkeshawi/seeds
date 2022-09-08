import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seeds/app_router.dart';
import 'package:seeds/seedsColors.dart';

errorFace() {
  return AlertDialog(
    backgroundColor: SeedsColors.secondColor,
    title: Text(
      'errorTitle'.tr(),
      style: TextStyle(color: SeedsColors.secondMain, fontSize: 24.sp),
    ),
    content: Text(
      'errorBody'.tr(),
      style: TextStyle(color: SeedsColors.freeStar, fontSize: 18.sp),
    ),
  );
}
