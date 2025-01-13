import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paynow_e_wallet_app/core/params/profile_params.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_state.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({super.key});

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthBloc(updateUserUsecase: sl()),
        child: BlocConsumer(listener: (context, state) {
          if (state is UpdatedUser) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')));
          }
          if (state is ErrorUpdatingUser) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        }, builder: (context, state) {
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
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          color: AppColors.bgGray,
                          shape: BoxShape.circle,
                        ),
                        child: _selectedImage != null
                            ? Image.file(
                                File(_selectedImage!.path),
                                fit: BoxFit.cover,
                              )
                            : SvgPicture.asset(
                                ImageConstants.profileActive,
                                height: 32.w,
                                width: 32.w,
                              ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Center(
                        child: TextButton(
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              // Pick an image.
                              _selectedImage = await picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {});
                            },
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
                            const Text('Name'),
                            SizedBox(height: 5.h),
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                  hintText: 'Enter your name'),
                            ),
                            SizedBox(height: 10.h),
                            // const Text('Email'),
                            // SizedBox(height: 5.h),
                            // TextFormField(
                            //   decoration:
                            //       const InputDecoration(hintText: 'Enter your email'),
                            // ),
                            // SizedBox(height: 10.h),
                            const Text('Phone number'),
                            SizedBox(height: 5.h),
                            TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                  hintText: 'Enter your phone number'),
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
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(UpdateUserEvent(
                                  params: UpdateUserParams(
                                      id: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      avatar: _selectedImage,
                                      name: _nameController.text,
                                      phoneNumber: _phoneController.text)));
                            }
                          },
                    child: const Text('Save changes')),
              ),
            ),
          );
        }));
  }
}
