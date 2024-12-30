import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: AppBar(
            title: const Text('Contacts'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: SvgPicture.asset(
                  ImageConstants.add,
                  color: Theme.of(context).colorScheme.primary,
                  height: 24.w,
                  width: 24.w,
                ),
                onPressed: () {},
              ),
              SizedBox(width: 10.w),
            ],
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(2.h), child: const Divider()),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter a name',
                  prefixIcon: SvgPicture.asset(
                    ImageConstants.search,
                    fit: BoxFit.fill,
                    color: AppColors.gray,
                    height: 24.w,
                    width: 24.w,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      contentPadding: EdgeInsets.zero,
                      leading: Image.asset(
                        ImageConstants.profilePicture1,
                        height: 40.w,
                        width: 40.w,
                      ),
                      horizontalTitleGap: 5.w,
                      title: const Text('Ahmad Ismail'),
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      subtitle: Text('ahmad.ismail@gmail.com',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.gray)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 40.h,
                            width: 40.w,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {},
                                child: SvgPicture.asset(ImageConstants.send,
                                    height: 20.w, width: 20.w)),
                          ),
                          SizedBox(width: 8.w),
                          SizedBox(
                            height: 40.h,
                            width: 40.w,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {},
                                child: SvgPicture.asset(ImageConstants.request,
                                    height: 20.w, width: 20.w)),
                          ),
                        ],
                      ),
                      onTap: () {},
                    );
                  },
                  itemCount: 3)
            ],
          ),
        ));
  }
}
