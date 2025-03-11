import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_e_wallet_app/core/helper/notification_service.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_event.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late List<SettingItem> generalItems;
  late List<SettingItem> notificationItems;
  late List<SettingItem> moreItems;
  @override
  void initState() {
    generalItems = [
      SettingItem(
        title: 'Language',
        subtitle: 'Change the language of the app.',
        icon: ImageConstants.language,
        onTap: () {},
      ),
      SettingItem(
        title: 'Locations',
        subtitle: 'Add your home and work locations.',
        icon: ImageConstants.location,
        onTap: () {},
      ),
    ];

    notificationItems = [
      SettingItem(
        title: 'Push notifications',
        subtitle: 'For daily update and others.',
        icon: ImageConstants.notifications,
        onTap: () {},
      ),
      SettingItem(
        title: 'Promotional notifications',
        subtitle: 'New campain and offers.',
        icon: ImageConstants.notifications,
        onTap: () {},
      ),
    ];

    moreItems = [
      SettingItem(
        title: 'Contact us',
        subtitle: 'For more information',
        icon: ImageConstants.call,
        onTap: () {},
      ),
      SettingItem(
        title: 'Logout',
        subtitle: '',
        icon: ImageConstants.logout,
        onTap: () async {
          await sl<NotificationService>()
              .removeFCMToken(context.read<AuthBloc>().state.userEntity!.id!);
          await FirebaseAuth.instance.signOut();
          context.read<AuthBloc>().add(LogoutEvent());
          context.read<ContactBloc>().add(ClearContactStateEvent());
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouteEnum.loginPage.name,
            (route) => false,
          );
        },
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 24.w,
            )),
        title: const Text('Settings'),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.h), child: const Divider()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'General',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.primaryColor),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: SvgPicture.asset(
                      generalItems[index].icon,
                      height: 24.w,
                      width: 24.w,
                    ),
                    title: Text(generalItems[index].title),
                    subtitle: Text(generalItems[index].subtitle),
                    titleTextStyle: Theme.of(context).textTheme.bodyLarge!,
                    subtitleTextStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.gray),
                    onTap: generalItems[index].onTap,
                  );
                },
                itemCount: generalItems.length,
              ),
              const Divider(),
              Text(
                'Notifications',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.primaryColor),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: SvgPicture.asset(
                      notificationItems[index].icon,
                      height: 24.w,
                      width: 24.w,
                    ),
                    title: Text(notificationItems[index].title),
                    subtitle: Text(notificationItems[index].subtitle),
                    titleTextStyle: Theme.of(context).textTheme.bodyLarge!,
                    subtitleTextStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.gray),
                    onTap: notificationItems[index].onTap,
                  );
                },
                itemCount: notificationItems.length,
              ),
              const Divider(),
              Text(
                'More',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.primaryColor),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: SvgPicture.asset(
                      moreItems[index].icon,
                      height: 24.w,
                      width: 24.w,
                    ),
                    title: Text(moreItems[index].title),
                    subtitle: moreItems[index].subtitle.isEmpty
                        ? null
                        : Text(moreItems[index].subtitle),
                    titleTextStyle: Theme.of(context).textTheme.bodyLarge!,
                    subtitleTextStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.gray),
                    onTap: moreItems[index].onTap,
                  );
                },
                itemCount: moreItems.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingItem {
  final String title;
  final String subtitle;
  final String icon;
  final VoidCallback onTap;

  SettingItem(
      {required this.title,
      required this.subtitle,
      required this.icon,
      required this.onTap});
}
