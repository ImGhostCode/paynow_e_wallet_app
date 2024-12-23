import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(
        seconds: 1,
      ),
      () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouteEnum.introPage.name,
          (route) => false,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Image.asset(
            ImageConstants.logo,
            width: 106.w,
            height: 173.h,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
