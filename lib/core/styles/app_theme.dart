import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/core/styles/app_text_style.dart';

// import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Light theme
final ThemeData lightTheme = ThemeData(
  // dialogBackgroundColor: AppColors.lightGray,
  // cardColor: AppColors.primaryColor,
  appBarTheme: AppBarTheme(
      // shadowColor: AppColors.lightGray,
      iconTheme: IconThemeData(color: AppColors.black, size: 24.w),
      color: AppColors.white,
      titleTextStyle:
          AppTextStyle.xLargeBlack.copyWith(fontWeight: FontWeight.w500)
      // elevation: 2,
      // toolbarTextStyle: const TextTheme(
      //   titleLarge: AppTextStyle.xxxLargeBlack,
      // ).bodyLarge,
      // titleTextStyle: const TextTheme(
      //   titleLarge: AppTextStyle.xxxLargeBlack,
      // ).titleLarge,
      // systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
  fontFamily: "SFProRounded",
  scaffoldBackgroundColor: AppColors.white,
  brightness: Brightness.light,
  iconTheme: IconThemeData(color: AppColors.black, size: 24.w),
  textTheme: TextTheme(
      headlineLarge: AppTextStyle.xxxLargeBlack, // 40
      headlineMedium: AppTextStyle.xxLargeBlack, // 32
      headlineSmall: AppTextStyle.largeBlack, // 16
      titleLarge: AppTextStyle.xLargeBlack, // 20
      titleMedium: AppTextStyle.largeBlack, // 16
      titleSmall: AppTextStyle.smallBlack, // 12
      bodyLarge: AppTextStyle.largeBlack, // 16
      bodyMedium: AppTextStyle.mediumBlack, // 14
      bodySmall: AppTextStyle.smallBlack), // 12
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        textStyle: TextStyle(fontSize: 14.sp, color: Colors.white),
        foregroundColor: Colors.white),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        // backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        textStyle: TextStyle(fontSize: 14.sp, color: Colors.black),
        foregroundColor: Colors.black),
  ),
  colorScheme: ColorScheme.fromSeed(
      primary: AppColors.primaryColor,
      seedColor: AppColors.primaryColor,
      secondary: AppColors.secondaryColor),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.white,
      filled: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 10.h,
      ),
      hintStyle: AppTextStyle.mediumBlack.copyWith(color: AppColors.gray),
      suffixIconColor: AppColors.black,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: BorderSide(color: AppColors.border, width: 1)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: BorderSide(color: AppColors.border, width: 1)),
      errorMaxLines: 2),
);

/// Dark theme
final ThemeData darkTheme = ThemeData(
  // dialogBackgroundColor: AppColors.primaryColor,
  // cardColor: AppColors.orange.withOpacity(0.5),
  // appBarTheme: AppBarTheme(
  //   shadowColor: AppColors.white,
  //   color: AppColors.darkGray,
  //   elevation: 0,
  //   toolbarTextStyle: const TextTheme(
  //     titleLarge: AppTextStyle.xxxLargeWhite,
  //   ).bodyLarge,
  //   titleTextStyle: const TextTheme(
  //     titleLarge: AppTextStyle.xxxLargeWhite,
  //   ).titleLarge,
  //   systemOverlayStyle: SystemUiOverlayStyle.light,
  // ),
  fontFamily: "SFProRounded",
  scaffoldBackgroundColor: Colors.black,
  brightness: Brightness.dark,
  iconTheme: const IconThemeData(color: AppColors.white, size: 24),
  textTheme: TextTheme(
      headlineLarge: AppTextStyle.xxxLargeWhite,
      headlineMedium: AppTextStyle.xxLargeWhite,
      titleLarge: AppTextStyle.xLargeWhite,
      titleMedium: AppTextStyle.largeWhite,
      titleSmall: AppTextStyle.smallWhite,
      bodyLarge: AppTextStyle.largeWhite,
      bodyMedium: AppTextStyle.mediumWhite,
      bodySmall: AppTextStyle.smallWhite),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(
        // horizontal: 50.w,
        vertical: 12.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor, secondary: AppColors.secondaryColor),
  // inputDecorationTheme: InputDecorationTheme(
  //   contentPadding: EdgeInsets.symmetric(
  //     horizontal: 10.w,
  //   ),
  //   filled: true,
  //   suffixIconColor: AppColors.white,
  //   fillColor: AppColors.transparent,
  //   border: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(10.sp),
  //       borderSide: const BorderSide(color: AppColors.lightGray, width: 1)),
  //   enabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(10.sp),
  //       borderSide: const BorderSide(color: AppColors.lightGray, width: 1)),
  //   focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(10.sp),
  //       borderSide: const BorderSide(color: AppColors.lightGray, width: 1)),
  //   errorMaxLines: 2,
  // ),
);
