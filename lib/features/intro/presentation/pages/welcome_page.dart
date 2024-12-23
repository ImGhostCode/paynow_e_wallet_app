import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Transform(
            transform: Matrix4.identity()..translate(0.0, -150.0.h),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: OverflowBox(
                    maxHeight: 1500.h,
                    maxWidth: 1500.w,
                    child: Container(
                      height: Helper.isTablet(context) ? 950.h : 734.h,
                      width: Helper.isTablet(context) ? 950.w : 734.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            ImageConstants.logo,
                            height: 137.h,
                            width: 106.w,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            height: 120.h,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'The Best Way to',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' Transfer Money',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                const TextSpan(text: ' Safely!'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 90.h,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150.h,
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 315.w,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRouteEnum.signupPage.name);
                        },
                        child: const Text(
                          'Create new account',
                        )),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRouteEnum.loginPage.name);
                      },
                      child: Text('Already have an account?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.primary))),
                ],
              ))
        ],
      ),
    );
  }
}
