import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.user});
  final UserEntity user;

  final List<Transaction> transactions = [
    Transaction(
        type: TransactionType.send,
        userName: 'Yara Khalil',
        amount: 15,
        date: 'Oct 14, 10:24 AM',
        userImage: ImageConstants.profilePicture4),
    Transaction(
        type: TransactionType.request,
        userName: 'Sara Ibrahim',
        amount: 20,
        date: 'Oct 12, 02:13 PM',
        userImage: ImageConstants.profilePicture),
    Transaction(
        type: TransactionType.request,
        userName: 'Ahmad Ibrahim',
        amount: 12.4,
        date: 'Oct 11, 01:19 AM',
        userImage: ImageConstants.profilePicture5),
    Transaction(
        type: TransactionType.send,
        userName: 'Reem Khaled',
        amount: 21.3,
        date: 'Oct 07, 09:10 PM',
        userImage: ImageConstants.profilePicture1),
    Transaction(
        type: TransactionType.send,
        userName: 'Hiba Saleh',
        amount: 0.9,
        date: 'Oct 04, 05:45 AM',
        userImage: ImageConstants.profilePicture3)
  ];

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
                        'Hi, ${user.fullName.isNotEmpty ? user.fullName : user.id}!',
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
                            '\$${user.balance}',
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
                                    context, AppRouteEnum.requestsPage.name);
                              },
                              icon: Badge(
                                smallSize: 6.w,
                                largeSize: 10.w,
                                backgroundColor: const Color(0xFFF8BB18),
                                label: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                    ImageConstants.notifications,
                                    color: Colors.white,
                                    height: 24.w,
                                    width: 24.w),
                              )),
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
                    onPressed: () {},
                    child: const Text('View All'),
                  ),
                ],
              ),
              transactions.isEmpty
                  ? Column(
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
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.textGrey,
                                  ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          minTileHeight: 60.h,
                          leading: Stack(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: 40.w,
                                  maxWidth: 40.w,
                                ),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  transactions[index].userImage,
                                  fit: BoxFit.contain,
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
                                    transactions[index].type ==
                                            TransactionType.send
                                        ? ImageConstants.send
                                        : ImageConstants.request,
                                    color: transactions[index].type ==
                                            TransactionType.send
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Theme.of(context).colorScheme.primary,
                                    height: 24.h,
                                    width: 24.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                          title: Text(transactions[index].userName),
                          subtitle: Text(
                            transactions[index].date,
                          ),
                          subtitleTextStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.grey),
                          trailing: Text(
                            '${transactions[index].type == TransactionType.send ? '-' : '+'}\$${transactions[index].amount.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 5.h);
                      },
                      itemCount: transactions.length)
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

enum TransactionType { send, request }

class Transaction {
  final TransactionType type;
  final String userName;
  final String userImage;
  final double amount;
  final String date;

  Transaction({
    required this.type,
    required this.userName,
    required this.amount,
    required this.date,
    required this.userImage,
  });
}
