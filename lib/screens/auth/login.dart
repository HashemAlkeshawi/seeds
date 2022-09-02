import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seeds/seedsColors.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> loginForm = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: SeedsColors.secondColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/seedsLogo.svg',
                  height: 150.h,
                  width: 120.w,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.h),
              child: Text(
                'Login'.tr(),
                style: TextStyle(
                  color: SeedsColors.main,
                  fontSize: 21.sp,
                ),
              ),
            )
       ,
       Container(
        
        child: Form(child:  , key: loginForm,),
       )
          ],
        ),
      ),
    );
  }
}
