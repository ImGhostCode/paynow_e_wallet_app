import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';

class MyCardsPage extends StatefulWidget {
  const MyCardsPage({super.key});

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  int _currentCard = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        title: const Text('My Cards'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouteEnum.addCardPage.name);
              },
              icon: SvgPicture.asset(
                ImageConstants.add,
                color: AppColors.primaryColor,
                height: 24.w,
                width: 24.w,
              ))
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.h), child: const Divider()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentCard = index;
                  });
                },
                height: 160.0.w,
                enableInfiniteScroll: false,
              ),
              items: [
                1,
                2,
                3,
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          gradient: const LinearGradient(colors: [
                            Color(0xFF1A87DD),
                            Color(0xFF45A7F5),
                          ])),
                      child: Stack(
                        children: [
                          Positioned(
                              left: MediaQuery.of(context).size.width / 4,
                              bottom: 0,
                              child: Opacity(
                                opacity: 0.1,
                                child: SvgPicture.asset(
                                  ImageConstants.visaLogo,
                                  height: 150.w,
                                  width: 400.w,
                                ),
                              )),
                          Positioned.fill(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 12.w),
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: SvgPicture.asset(
                                        ImageConstants.visaLogo,
                                        height: 12.w,
                                        width: 32.w,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      ImageConstants.chipset,
                                      height: 25.w,
                                      width: 35.w,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      '1234  5678  9123  4567',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Cardholder',
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              'Tanya Robinson',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.white),
                                            )
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Exp. Date',
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              '02/23',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ))
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 2, 3].asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: _currentCard == entry.key ? 8.0.w : 6.w,
                    height: _currentCard == entry.key ? 8.0.w : 6.w,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0.w, horizontal: 2.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentCard == entry.key
                            ? AppColors.primaryColor
                            : const Color(0xFF8FA1B4)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Cardholder Name'),
                      SizedBox(height: 5.h),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Enter your name as written on card'),
                      ),
                      SizedBox(height: 15.h),
                      const Text('Card Number'),
                      SizedBox(height: 5.h),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Enter card number'),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('cvv\\cvc'),
                              SizedBox(height: 5.h),
                              TextFormField(
                                decoration:
                                    const InputDecoration(hintText: '123'),
                              ),
                            ],
                          )),
                          SizedBox(
                            width: 15.w,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Exp.Date'),
                              SizedBox(height: 5.h),
                              TextFormField(
                                decoration:
                                    const InputDecoration(hintText: '20\\20'),
                              ),
                            ],
                          ))
                        ],
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: 375.w,
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5.r,
              offset: const Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50.h,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: const Text('Save changes')),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            SizedBox(
              height: 50.h,
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.all(24.w),
                          content: Container(
                            color: AppColors.white,
                            width: 396.w,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  ImageConstants.removeIllustration,
                                  height: 180.w,
                                  width: 240.w,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  'Are you sure to remove this card?',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 50.h,
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                                // padding: EdgeInsets.symmetric(
                                                //     vertical: 16.w),
                                                foregroundColor:
                                                    AppColors.primaryColor),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel')),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 50.h,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                // padding: EdgeInsets.symmetric(
                                                //     vertical: 8.w),
                                                backgroundColor: AppColors.red),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Remove')),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    ImageConstants.remove,
                    height: 24.w,
                    width: 24.w,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
