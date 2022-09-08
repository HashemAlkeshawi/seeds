import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:seeds/app_router.dart';
import 'package:seeds/data/Seeds_api/dio_helper.dart';
import 'package:seeds/data/Seeds_api/seed_provider.dart';
import 'package:seeds/screens/auth/creat_account.dart';
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
                  height: 100.h,
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
            ),
            Consumer<SeedsProvider>(
              builder: (context, provider, child) => Form(
                child: Column(
                  key: loginForm,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                          // color: SeedsColors.thirdColor,
                          borderRadius: BorderRadius.circular(20.r)),
                      width: 300.w,
                      child: IntlPhoneField(
                        validator: (value) {
                          if (value!.number.length != 9) {
                            return 'invalidNumber'.tr();
                          } else {
                            return null;
                          }
                        },
                        disableLengthCheck: true,
                        style: TextStyle(color: SeedsColors.freeStar),
                        dropdownTextStyle:
                            TextStyle(color: SeedsColors.freeStar),
                        dropdownIcon: Icon(
                          Icons.arrow_drop_down,
                          color: SeedsColors.freeStar,
                          size: 30.r,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: SeedsColors.freeStar),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: SeedsColors.active),
                            ),
                            hintText: 'phoneNumber'.tr(),
                            hintStyle: TextStyle(
                              fontSize: 16.sp,
                              color: SeedsColors.freeStar,
                            )),
                        initialCountryCode: 'PS',
                        onChanged: (phone) {
                          provider.phoneNumber =
                              phone.completeNumber.replaceFirst('0', '2');
                          ;
                          print(provider.phoneNumber);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: InkWell(
                        onTap: () async {
                          String phoneNumber = provider.phoneNumber ?? '';
                          if (phoneNumber.length != 13) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('enterPhoneNumber'.tr())));
                          } else {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return Center(
                                    child: SizedBox(
                                        height: 40.h,
                                        width: 40.h,
                                        child: CircularProgressIndicator(
                                          color: SeedsColors.main,
                                        )),
                                  );
                                });
                            bool check = await provider.checkCustomer();
                            if (!check) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('invalidphonenumber'.tr())));
                              AppRouter.navigateWithReplacemtnToWidget(
                                  CreatAccount());
                            }
                          }
                        },
                        child: Center(
                            child: Container(
                          decoration: BoxDecoration(
                            color: SeedsColors.thirdColor,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          height: 60.h,
                          width: 130.w,
                          child: Center(
                            child: Text(
                              'Login'.tr(),
                              style: TextStyle(
                                  color: SeedsColors.freeStar, fontSize: 18.sp),
                            ),
                          ),
                        )),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 40.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 110.w,
                              height: 3.h,
                              color: SeedsColors.thirdColor,
                            ),
                            Text(
                              'or'.tr(),
                              style: TextStyle(
                                  fontSize: 20.sp, color: SeedsColors.freeStar),
                            ),
                            Container(
                              width: 110.w,
                              height: 3.h,
                              color: SeedsColors.thirdColor,
                            ),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 30.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'donthaveaccount'.tr(),
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: SeedsColors.freeStar,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              AppRouter.navigateToWidget(CreatAccount());
                            },
                            child: Text(
                              'createAccount'.tr(),
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: SeedsColors.main,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
