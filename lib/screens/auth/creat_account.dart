import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:seeds/app_router.dart';
import 'package:seeds/data/Seeds_api/seed_provider.dart';
import 'package:seeds/screens/auth/login.dart';
import 'package:seeds/seedsColors.dart';

class CreatAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> loginForm = GlobalKey<FormState>();
    return Consumer<SeedsProvider>(
      builder: (BuildContext context, provider, child) {
        return Scaffold(
          backgroundColor: SeedsColors.secondColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, top: 60.h, bottom: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Text(
                          'createAccount'.tr(),
                          style: TextStyle(
                            color: SeedsColors.main,
                            fontSize: 21.sp,
                          ),
                        ),
                      ),
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/seedsLogo.svg',
                          height: 65.h,
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: loginForm,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: SeedsColors.secondColor,
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await provider
                                          .selectImage(ImageSource.camera);
                                      AppRouter.popFromWidget();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8.r),
                                      decoration: BoxDecoration(
                                          color: SeedsColors.thirdColor,
                                          borderRadius:
                                              BorderRadius.circular(25.r)),
                                      height: 120.h,
                                      width: 100.w,
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.camera_alt,
                                            size: 70.r,
                                            color: SeedsColors.main,
                                          ),
                                          Text(
                                            'camera'.tr(),
                                            style: TextStyle(
                                              color: SeedsColors.freeStar,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await provider
                                          .selectImage(ImageSource.gallery);
                                      AppRouter.popFromWidget();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8.r),
                                      decoration: BoxDecoration(
                                          color: SeedsColors.thirdColor,
                                          borderRadius:
                                              BorderRadius.circular(25.r)),
                                      height: 120.h,
                                      width: 100.w,
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.image,
                                            size: 70.r,
                                            color: SeedsColors.main,
                                          ),
                                          Text(
                                            'gallery'.tr(),
                                            style: TextStyle(
                                              color: SeedsColors.freeStar,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 130,
                          width: MediaQuery.of(context).size.width,
                          child: provider.profileImage == null
                              ? CircleAvatar(
                                  backgroundColor: SeedsColors.thirdColor,
                                  radius: 130.r,
                                  child: Icon(
                                    Icons.add,
                                    size: 40.r,
                                  ))
                              : CircleAvatar(
                                  backgroundColor: SeedsColors.thirdColor,
                                  radius: 130.r,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                        provider.profileImage!,
                                      )),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r)),
                          width: 300.w,
                          child: TextFormField(
                            controller: provider.nameCreation,
                            validator: (value) {
                              if (value!.length < 6) {
                                return 'Enter valid name';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(
                                color: SeedsColors.freeStar, fontSize: 18.sp),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: SeedsColors.freeStar),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: SeedsColors.active),
                                ),
                                hintText: 'name'.tr(),
                                hintStyle: TextStyle(
                                  fontSize: 16.sp,
                                  color: SeedsColors.freeStar,
                                )),
                          )),
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
                                borderSide:
                                    BorderSide(color: SeedsColors.active),
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
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: Center(
                          child: InkWell(
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                print(provider.phoneNumber);
                                if (loginForm.currentState!.validate()) {
                                  await provider.verifyPhoneNumberCreation(
                                      provider.phoneNumber!);
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
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('fillAllFields'.tr())));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: SeedsColors.thirdColor,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                height: 65.h,
                                width: 140.w,
                                child: Center(
                                  child: Text(
                                    'createAccount'.tr(),
                                    style: TextStyle(
                                        color: SeedsColors.freeStar,
                                        fontSize: 18.sp),
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
                                    fontSize: 20.sp,
                                    color: SeedsColors.freeStar),
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
                            vertical: 10.h, horizontal: 70.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'alreadyhaveaccount'.tr(),
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: SeedsColors.freeStar,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                AppRouter.navigateWithReplacemtnToWidget(
                                    LogIn());
                              },
                              child: Text(
                                'Login'.tr(),
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
