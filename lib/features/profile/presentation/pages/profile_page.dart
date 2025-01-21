import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/styles/app_text_style.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final List<Item> items = [
      Item(
        title: 'My Info',
        icon: ImageConstants.profileActive,
        onTap: () {
          Navigator.pushNamed(context, AppRouteEnum.myInfoPage.name);
        },
      ),
      Item(
        title: 'Reset Password',
        icon: ImageConstants.password,
        onTap: () {
          Navigator.pushNamed(context, AppRouteEnum.resetPasswordPage.name);
        },
      ),
      Item(
        title: 'My cards',
        icon: ImageConstants.card,
        onTap: () {
          Navigator.pushNamed(context, AppRouteEnum.myCardsPage.name);
        },
      ),
      Item(
        title: 'Settings',
        icon: ImageConstants.setting,
        onTap: () {
          Navigator.pushNamed(context, AppRouteEnum.settingsPage.name);
        },
      ),
      Item(
        title: 'Help Center',
        icon: ImageConstants.help,
        onTap: () {},
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.bgGray,
          title: const Text('Profile'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                ImageConstants.edit,
                color: Theme.of(context).colorScheme.primary,
                height: 24.w,
                width: 24.w,
              ),
              onPressed: () {},
            ),
            SizedBox(width: 10.w),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: AppColors.bgGray,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100.w,
                      width: 100.w,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: user.avatar.isNotEmpty
                          ? Image.network(user.avatar, fit: BoxFit.fill)
                          : user.name != ''
                              ? Center(
                                  child: Text(user.name[0],
                                      style: AppTextStyle.xxxLargeBlack
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                )
                              : SvgPicture.asset(
                                  ImageConstants.profileActive,
                                  height: 32.w,
                                  width: 32.w,
                                  fit: BoxFit.none,
                                ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      user.name != '' ? user.name : user.email,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              ListView.separated(
                padding: EdgeInsets.all(15.r),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: AppColors.bgGray,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.h, vertical: 6.w),
                    leading: SvgPicture.asset(
                      items[index].icon,
                      height: 24.w,
                      width: 24.w,
                    ),
                    horizontalTitleGap: 8.w,
                    title: Text(items[index].title,
                        style: Theme.of(context).textTheme.bodyMedium),
                    trailing: SvgPicture.asset(
                      ImageConstants.arrowRight,
                      height: 24.h,
                      width: 24.w,
                    ),
                    onTap: items[index].onTap,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 15.h);
                },
                itemCount: items.length,
              )
            ],
          ),
        ));
  }
}

class Item {
  final String title;
  final String icon;
  final VoidCallback onTap;

  Item({required this.title, required this.icon, required this.onTap});
}
