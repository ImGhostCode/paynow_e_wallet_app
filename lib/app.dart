import 'package:flutter/material.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/pages/contact_page.dart';
import 'package:paynow_e_wallet_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/features/profile/presentation/pages/profile_page.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/pages/transaction_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SkeletonApp();
  }
}

class SkeletonApp extends StatefulWidget {
  const SkeletonApp({super.key});

  @override
  State<SkeletonApp> createState() => _SkeletonAppState();
}

class _SkeletonAppState extends State<SkeletonApp> {
  int _selectedIndex = 0;
  final List<NavBarItem> navBarItem = [
    NavBarItem(
      title: 'Home',
      icon: ImageConstants.home,
      activeIcon: ImageConstants.homeActive,
    ),
    NavBarItem(
      title: 'Transactions',
      icon: ImageConstants.transaction,
      activeIcon: ImageConstants.transactionActive,
    ),
    NavBarItem(
      title: 'Contacts',
      icon: ImageConstants.contact,
      activeIcon: ImageConstants.contactActive,
    ),
    NavBarItem(
      title: 'Profile',
      icon: ImageConstants.profile,
      activeIcon: ImageConstants.profileActive,
    ),
  ];
  final List<Widget> _pages = <Widget>[
    HomePage(),
    const TransactionPage(),
    const ContactPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, -10.h),
          ),
        ]),
        child: Container(
          // height: 70.h,
          constraints: BoxConstraints(
            maxHeight: 70.h,
          ),
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: BottomNavigationBar(
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            selectedIconTheme: IconThemeData(size: 20.w),
            items: navBarItem
                .map(
                  (e) => BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      e.icon,
                      height: 20.w,
                      width: 20.w,
                    ),
                    activeIcon: SvgPicture.asset(
                      e.activeIcon,
                      height: 20.w,
                      width: 20.w,
                    ),
                    label: e.title,
                  ),
                )
                .toList(),
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedItemColor: AppColors.black,
            unselectedItemColor: AppColors.gray,
            // showSelectedLabels: false,
            // showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.bgGray,
            iconSize: 20.w,
          ),
        ),
      ),
    );
  }
}

class NavBarItem {
  final String title;
  final String icon;
  final String activeIcon;

  NavBarItem({
    required this.title,
    required this.icon,
    required this.activeIcon,
  });
}
