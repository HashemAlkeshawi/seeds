import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seeds/app_router.dart';
import 'package:seeds/data/Seeds_api/seed_provider.dart';
import 'package:seeds/screens/home.dart';
import 'package:seeds/seedsColors.dart';
import 'package:seeds/widgets/appBar.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('profile'.tr()),
      body: Consumer<SeedsProvider>(
        builder: (context, provider, child) {
          return Container(
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
                        backgroundColor: SeedsColors.thirdColor,
                        radius: 130.r,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  provider.theCustomer!.imageUrl!,
                                )),
                            shape: BoxShape.circle,
                          ),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                provider.theCustomer!.fullName,
                                style: TextStyle(
                                    color: SeedsColors.main, fontSize: 21.sp),
                              ),
                            ),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                provider.theCustomer!.phone,
                                style: TextStyle(
                                    color: SeedsColors.main, fontSize: 21.sp),
                              ),
                            ),
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
                          'ActivationLabel'.tr(),
                          style: TextStyle(
                              color: SeedsColors.freeStar, fontSize: 14.sp),
                        ),
                      ),
                      provider.theCustomer!.status == 0
                          ? Text(
                              'inactive'.tr(),
                              style: TextStyle(
                                  color: SeedsColors.inactive, fontSize: 14.sp),
                            )
                          : provider.theCustomer!.status == 1
                              ? Text(
                                  'pending'.tr(),
                                  style: TextStyle(
                                      color: SeedsColors.main, fontSize: 14.sp),
                                )
                              : Text(
                                  'active'.tr(),
                                  style: TextStyle(
                                      color: SeedsColors.active,
                                      fontSize: 14.sp),
                                ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    insetPadding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    backgroundColor: SeedsColors.secondColor,
                                    title: Text(
                                      'accountActivation'.tr(),
                                      style: TextStyle(
                                          color: SeedsColors.main,
                                          fontSize: 28.sp),
                                    ),
                                    content: Text(
                                      'activationInfoContent'.tr(),
                                      style: TextStyle(
                                        color: SeedsColors.freeStar,
                                        wordSpacing: 2.w,
                                        fontSize: 22.sp,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            AppRouter.popFromWidget();
                                          },
                                          child: Text(
                                            'ok'.tr(),
                                            style: TextStyle(
                                              color: SeedsColors.freeStar,
                                              fontSize: 18.sp,
                                            ),
                                          ))
                                    ],
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.info_outline,
                            color: SeedsColors.freeStar,
                          ))
                    ],
                  ),
                ),
                provider.theCustomer!.status == 0
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 24.h),
                          child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor:
                                            SeedsColors.secondColor,
                                        title: Text(
                                          'accountActivation'.tr(),
                                          style: TextStyle(
                                            color: SeedsColors.main,
                                            fontSize: 24.sp,
                                          ),
                                        ),
                                        content: Text(
                                          'activationRequistContent'.tr(),
                                          style: TextStyle(
                                            color: SeedsColors.freeStar,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              AppRouter.popFromWidget();
                                            },
                                            child: Text(
                                              'cancel'.tr(),
                                              style: TextStyle(
                                                  color: SeedsColors.main),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) {
                                                    return Center(
                                                      child: SizedBox(
                                                          height: 40.h,
                                                          width: 40.h,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: SeedsColors
                                                                .main,
                                                          )),
                                                    );
                                                  });
                                              await provider.upDateCustomer();
                                              AppRouter
                                                  .navigateWithReplacemtnToWidget(
                                                      Profile());
                                            },
                                            child: Text(
                                              'send'.tr(),
                                              style: TextStyle(
                                                  color: SeedsColors.main),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
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
                                        color: SeedsColors.secondColor,
                                        fontSize: 12.sp),
                                  ),
                                ),
                              )),
                        ),
                      )
                    : provider.theCustomer!.status == 1
                        ? Center(
                            child: Container(
                              width: 155.w,
                              height: 55.h,
                              decoration: BoxDecoration(
                                color: SeedsColors.thirdColor,
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                              child: Center(
                                child: Text(
                                  'requistSent'.tr(),
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 14.sp),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Row(
                      children: [
                        Text(
                          'logout'.tr(),
                          style: TextStyle(
                              color: SeedsColors.freeStar, fontSize: 16.sp),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        backgroundColor:
                                            SeedsColors.secondColor,
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              AppRouter.popFromWidget();
                                            },
                                            child: Text(
                                              'cancel'.tr(),
                                              style: TextStyle(
                                                  color: SeedsColors.main),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              provider.signOut();
                                              AppRouter
                                                  .navigateWithReplacemtnToWidget(
                                                      Home());
                                            },
                                            child: Text(
                                              'logout'.tr(),
                                              style: TextStyle(
                                                  color: SeedsColors.main),
                                            ),
                                          ),
                                        ],
                                        title: Text(
                                          'logout'.tr(),
                                          style: TextStyle(
                                              color: SeedsColors.freeStar,
                                              fontSize: 24.sp),
                                        ),
                                        content: Text(
                                          'doyouwanttologout'.tr(),
                                          style: TextStyle(
                                              color: SeedsColors.freeStar,
                                              fontSize: 20.sp),
                                        ),
                                      ));
                            },
                            icon: Icon(
                              Icons.logout,
                              color: SeedsColors.secondMain,
                              size: 40.r,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
