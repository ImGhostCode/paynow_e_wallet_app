import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:paynow_e_wallet_app/app.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';
import 'package:paynow_e_wallet_app/features/auth/business/usecases/get_user_usecase.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/bloc/card_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(180.w),
          child: AppBar(
            toolbarHeight: 50.w,
            title: const Text('Dashboard'),
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
            centerTitle: false,
            actions: [
              GestureDetector(
                onTap: null,
                child: CircleAvatar(
                  // radius: 30.r,
                  backgroundColor: Colors.white,
                  backgroundImage: user.avatar.isNotEmpty
                      ? NetworkImage(
                          user.avatar,
                        )
                      : null,
                  child: user.avatar.isEmpty
                      ? SvgPicture.asset(ImageConstants.profileActive)
                      : null,
                ),
              ),
              SizedBox(width: 20.w),
            ],
            flexibleSpace: Container(
              color: Theme.of(context).colorScheme.primary,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Container(
                          color: Theme.of(context).colorScheme.primary)),
                  ClipPath(
                    clipper: RightTriangleClipper(),
                    child: Container(
                      color: const Color(0xFF3491DB),
                      // height: 100.h,
                    ),
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Hi, ${user.name.isNotEmpty ? user.name : user.id}!',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white.withOpacity(0.5),
                            ),
                      ),
                      Text(
                        'Total Balance',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${context.watch<CardBloc>().state.totalBalance.toStringAsFixed(1)}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRouteEnum.notificationPage.name);
                            },
                            // icon: Badge(
                            //   smallSize: 6.w,
                            //   largeSize: 10.w,
                            //   backgroundColor: const Color(0xFFF8BB18),
                            //   label: Container(
                            //     decoration: BoxDecoration(
                            //       color:
                            //           Theme.of(context).colorScheme.secondary,
                            //       shape: BoxShape.circle,
                            //     ),
                            //   ),
                            // child: SvgPicture.asset(
                            //     ImageConstants.notifications,
                            //     color: Colors.white,
                            //     height: 24.w,
                            //     width: 24.w),
                            icon: SvgPicture.asset(ImageConstants.notifications,
                                color: Colors.white, height: 24.w, width: 24.w),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50.h,
                    width: 165.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRouteEnum.sendMoneyPage.name);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImageConstants.send,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            'Send Money',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                    width: 165.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRouteEnum.requestMoneyPage.name);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImageConstants.request,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 5.w),
                          const Text('Request Money'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last Transactions',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  // const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(8.w),
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                    onPressed: () {
                      context.read<NavIndexCubit>().changeIndex(1);
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is TransactionLoadingError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state is TransactionLoaded && state.transactions.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(height: 100.h),
                      SvgPicture.asset(
                        ImageConstants.emptyIllustration,
                        height: 100.w,
                        width: 100.w,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'There’s no transactions till now!',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.textGrey,
                            ),
                      ),
                    ],
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final element = state.transactions[index];
                    return BlocProvider(
                        create: (context) => AuthBloc(
                              getUserUsecase: sl<GetUserUsecase>(),
                            )..add(GetUserEvent(id: element.senderId)),
                        child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                          if (state is IsLoadingUser) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is ErrorLoadingUser) {
                            return Center(
                              child: Text(state.error),
                            );
                          }
                          if (state is LoadedUser) {
                            return ListTile(
                              minTileHeight: 60.h,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                state.userEntity?.name != null &&
                                        state.userEntity!.name.isNotEmpty
                                    ? state.userEntity!.name
                                    : element.senderId,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              horizontalTitleGap: 5.w,
                              subtitle: Text(
                                '${state.userEntity!.email} at ${DateFormat.jm('en_US').format(DateTime.parse(element.timestamp.toString()))}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: AppColors.gray,
                                    ),
                              ),
                              trailing: Text(
                                '+\$${element.amount.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              leading: Stack(
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: state.userEntity!.avatar.isNotEmpty
                                        ? Image.network(
                                            state.userEntity!.avatar,
                                            fit: BoxFit.cover,
                                            height: 40.w,
                                            width: 40.w,
                                          )
                                        : Image.asset(
                                            ImageConstants.defaultUser,
                                            height: 40.w,
                                            width: 40.w,
                                          ),
                                  ),
                                  Positioned(
                                    bottom: -3.h,
                                    right: -3.w,
                                    child: Container(
                                      alignment: Alignment.center,
                                      constraints: BoxConstraints(
                                        maxHeight: 24.h,
                                        maxWidth: 24.h,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        element.transactionType ==
                                                TransactionType.send.name
                                            ? ImageConstants.send
                                            : ImageConstants.request,
                                        color: element.transactionType ==
                                                TransactionType.send.name
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                        height: 24.h,
                                        width: 24.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                          return const SizedBox();
                        }));
                  },
                  itemCount: state.transactions.length,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class RightTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Right Trigle
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
