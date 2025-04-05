import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_e_wallet_app/core/helper/notification_service.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/bloc/card_bloc.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/bloc/card_event.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/pages/contact_page.dart';
import 'package:paynow_e_wallet_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:paynow_e_wallet_app/features/notification/presentation/bloc/notification_event.dart';
import 'package:paynow_e_wallet_app/features/profile/presentation/pages/profile_page.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/pages/transaction_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SkeletonApp();
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class SkeletonApp extends StatefulWidget {
  const SkeletonApp({super.key});

  @override
  State<SkeletonApp> createState() => _SkeletonAppState();
}

class _SkeletonAppState extends State<SkeletonApp> {
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
  User? user;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        sl<NotificationService>().saveFCMToken(user?.uid).then((_) {
          if (context.mounted) {
            BlocProvider.of<AuthBloc>(context)
                .add(GetUserEvent(id: user?.uid ?? ""));
            BlocProvider.of<CardBloc>(context)
                .add(GetCardEvent(userId: user?.uid ?? ""));
            BlocProvider.of<NotificationBloc>(context)
                .add(GetNotificationEvent(userId: user?.uid ?? ""));
            BlocProvider.of<TransactionBloc>(context)
                .add(GetRequestsEvent(userId: user?.uid ?? ""));
          }
        });
        sl<NotificationService>().firebaseInit(context);
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return BlocBuilder<AuthBloc, AuthState>(buildWhen: (previous, current) {
      return current is IsLoadingUser ||
          current is LoadedUser ||
          current is ErrorLoadingUser;
    }, builder: (context, state) {
      if (state is IsLoadingUser) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is ErrorLoadingUser) {
        return Scaffold(
          body: Center(
            child: Text(state.error),
          ),
        );
      } else if (state is LoadedUser) {
        return Scaffold(
          key: scaffoldKey,
          body: BlocBuilder<NavIndexCubit, int>(builder: (context, navState) {
            return IndexedStack(
              index: navState,
              children: [
                HomePage(
                  user: state.userEntity!,
                ),
                TransactionPage(
                  user: state.userEntity!,
                ),
                const ContactPage(),
                ProfilePage(
                  user: state.userEntity!,
                ),
              ],
            );
          }),
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
                maxHeight: 75.h,
              ),
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.bgGray,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < navBarItem.length; i++)
                    GestureDetector(
                      onTap: () {
                        context.read<NavIndexCubit>().changeIndex(i);
                      },
                      child: Container(
                        decoration: const BoxDecoration(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              context.watch<NavIndexCubit>().state == i
                                  ? navBarItem[i].activeIcon
                                  : navBarItem[i].icon,
                              height: 20.w,
                              width: 20.w,
                              color: context.watch<NavIndexCubit>().state == i
                                  ? Colors.black
                                  : AppColors.gray,
                            ),
                            Text(
                              navBarItem[i].title,
                              style: TextStyle(
                                color: context.watch<NavIndexCubit>().state == i
                                    ? Colors.black
                                    : AppColors.gray,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
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

class NavIndexCubit extends Cubit<int> {
  NavIndexCubit() : super(0);

  void changeIndex(int index) {
    emit(index);
  }
}
