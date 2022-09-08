import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:seeds/app_router.dart';
import 'package:seeds/data/Seeds_api/dio_helper.dart';
import 'package:seeds/data/Seeds_api/seed_provider.dart';
import 'package:seeds/screens/home.dart';
import 'package:seeds/seedsColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class verficationCode extends StatefulWidget {
  String verificationId;
  int? forceResendingToken;
  String phoneNumber;
  verficationCode(
      this.verificationId, this.forceResendingToken, this.phoneNumber);
  @override
  State<verficationCode> createState() => _verficationCodeState();
}

class _verficationCodeState extends State<verficationCode> {
  String? _code;
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
                        'verificationCode'.tr(),
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
                    VerificationCode(
                      textStyle:
                          TextStyle(fontSize: 20.0, color: Colors.red[900]),
                      keyboardType: TextInputType.number,
                      underlineColor: Colors
                          .amber, // If this is null it will use primaryColor: Colors.red from Theme
                      length: 6,
                      cursorColor: Colors
                          .blue, // If this is null it will default to the ambient
                      // clearAll is NOT required, you can delete it
                      // takes any widget, so you can implement your design
                      clearAll: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'clear all',
                          style: TextStyle(
                              fontSize: 14.0,
                              decoration: TextDecoration.underline,
                              color: Colors.blue[700]),
                        ),
                      ),
                      onCompleted: (String value) async {
                        setState(() {
                          _code = value;
                        });
                        showDialog(
                            barrierDismissible: false,
                            context: context,
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
                        FirebaseAuth auth = FirebaseAuth.instance;
                        String smsCode = _code!;

                        // Create a PhoneAuthCredential with the code
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: widget.verificationId,
                                smsCode: smsCode);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);
                        if (!await DioHelper.dioHelper
                            .checkCustomer(widget.phoneNumber)) {
                          await provider.addUser();
                        }
                        await provider.getCustomer(widget.phoneNumber);
                        await provider.checkUserStatus();
                        AppRouter.navigateWithReplacemtnToWidget(Home());
                      },
                      onEditing: (bool value) {},
                    ),
                    Padding(
                      padding: EdgeInsets.all(30.r),
                      child: InkWell(
                        onTap: () async {
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
                          try {
                            provider.verifyPhoneNumberCreation(
                                widget.phoneNumber,
                                forceResendingToken:
                                    widget.forceResendingToken);
                          } catch (e) {
                            AppRouter.popFromWidget();
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Text('invalidCode'.tr()),
                                    ));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 200.w),
                          child: Text(
                            'resendCode'.tr(),
                            style: TextStyle(
                              color: SeedsColors.active,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
