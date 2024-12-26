import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';

class MyInfoPage extends StatelessWidget {
  MyInfoPage({super.key});

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
        title: const Text('My Info'),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.h), child: const Divider()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 100.w,
                  width: 100.w,
                  decoration: const BoxDecoration(
                    color: AppColors.bgGray,
                    shape: BoxShape.circle,
                    // image: DecorationImage(
                    //   image: AssetImage(ImageConstants.profilePicture),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: SvgPicture.asset(
                    ImageConstants.profileActive,
                    height: 32.w,
                    width: 32.w,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Center(
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Upload image',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.primaryColor),
                      ))),
              SizedBox(height: 20.h),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('User Name'),
                      SizedBox(height: 5.h),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Enter your user name'),
                      ),
                      SizedBox(height: 10.h),
                      const Text('Email'),
                      SizedBox(height: 5.h),
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'Enter your email'),
                      ),
                      SizedBox(height: 10.h),
                      const Text('Mobile Phone'),
                      SizedBox(height: 5.h),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Enter your mobile phone'),
                      ),
                    ],
                  ))
            ],
          ),
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
        child: SizedBox(
          height: 50.h,
          child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: const Text('Save changes')),
        ),
      ),
    );
  }
}
