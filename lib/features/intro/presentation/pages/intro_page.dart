import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final List<Onboarding> onboardings = [
    Onboarding(
        title: 'Add all accounts & manage',
        description:
            'You can add all accounts in one place and use it to send and request.',
        image: ImageConstants.illustration2),
    Onboarding(
        title: 'Track your activity',
        description:
            'You can track your income, expenses activities and all statistics.',
        image: ImageConstants.illustration),
    Onboarding(
        title: 'Send & request payments',
        description: 'You can send or recieve any payments from yous accounts.',
        image: ImageConstants.walletRafiki),
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: 0, length: onboardings.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_tabController.index + 1}/${onboardings.length}',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              if (_tabController.index < onboardings.length - 1) {
                _tabController.animateTo(_tabController.index + 1);
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouteEnum.welcomePage.name,
                  (route) => false,
                );
              }
            },
            child: Text(
              'Skip',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: TabBarView(controller: _tabController, children: <Widget>[
              ...onboardings.map((onboarding) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          onboarding.image,
                          width: 375.w,
                          height: 280.h,
                        ),
                      ),
                      Text(
                        onboarding.title,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 240.w,
                        ),
                        child: Text(
                          onboarding.description,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.textGrey.withOpacity(0.6),
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
            ]),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(onboardings.length, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Container(
                      width: 15.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.r),
                        color: _tabController.index == index
                            ? Theme.of(context).colorScheme.primary
                            : AppColors.gray.withOpacity(0.3),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Onboarding {
  final String title;
  final String description;
  final String image;

  Onboarding({
    required this.title,
    required this.description,
    required this.image,
  });
}
