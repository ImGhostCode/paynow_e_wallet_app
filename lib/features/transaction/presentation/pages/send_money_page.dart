import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';

class SendMoneyPage extends StatelessWidget {
  SendMoneyPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController =
      TextEditingController(text: '12.50');

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
          title: const Text('Send Money'),
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(2.h), child: const Divider()),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.r),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                ListTile(
                  minLeadingWidth: 60.w,
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    height: 60.w,
                    width: 60.w,
                    decoration: const BoxDecoration(
                      color: AppColors.bgGray,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Y',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: const Text('Yara Khalil'),
                  subtitle: Text(
                    'yara_khalil@gmail.com',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.gray,
                        ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Payment Amount'),
                        TextFormField(
                          autofocus: true,
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.secondaryColor),
                          decoration: InputDecoration(
                            hintText: 'Enter amount',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                              borderSide: const BorderSide(
                                  color: AppColors.secondaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                              borderSide: const BorderSide(
                                  color: AppColors.secondaryColor),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter amount';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        const Text('Payment note'),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: 'Add payment note',
                          ),
                          validator: (value) {
                            return null;
                          },
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
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r)),
            ),
            child: SizedBox(
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.zero),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // send payment
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Container(
                            color: AppColors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  ImageConstants.sentIllustration,
                                  height: 180.w,
                                  width: 240.w,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  'The amount has been requested successfully!',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Ok, Thanks!')),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ImageConstants.send,
                      height: 24.w,
                      width: 24.w,
                    ),
                    const Text('Send Payment'),
                  ],
                ),
              ),
            )));
  }
}
