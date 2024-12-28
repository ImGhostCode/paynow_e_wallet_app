import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
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
        title: const Text('Add Card'),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.h), child: const Divider()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.h),
                      const Text('Card Number'),
                      SizedBox(height: 5.h),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Enter card number'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter card number';
                          }
                          return null;
                        },
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter cvv\\cvc';
                                  }
                                  return null;
                                },
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter expiry date';
                                  }
                                  return null;
                                },
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
        child: SizedBox(
          height: 50.h,
          child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: const Text('Submit Card')),
        ),
      ),
    );
  }
}
