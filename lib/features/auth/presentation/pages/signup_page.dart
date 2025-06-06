import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/app_constants.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isObscure2 = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(buildWhen: (previous, current) {
      return current is AuthLoading ||
          current is Authenticated ||
          current is Unauthenticated;
    }, listener: (context, state) {
      if (state is Authenticated) {
        Helper.showSnackBar(message: 'Sign up successfully', isSuccess: true);
        Navigator.pushReplacementNamed(context, AppRouteEnum.loginPage.name);
      } else if (state is Unauthenticated) {
        Helper.showSnackBar(message: state.error);
      }
    }, builder: (context, state) {
      return Scaffold(
          // resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    ImageConstants.background,
                    fit: BoxFit.fill,
                  ),
                ),
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 315.w,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'Signup and start transfering',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 50.h,
                                  width: 150.w,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.bgGray,
                                          foregroundColor: Colors.black),
                                      onPressed: () {},
                                      child: const Text('Google')),
                                ),
                                SizedBox(
                                  height: 50.h,
                                  width: 150.w,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          backgroundColor: AppColors.bgGray),
                                      onPressed: () {},
                                      child: const Text('Facebook')),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    TextFormField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your name',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return errorEmpty;
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    TextFormField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your email',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return errorEmpty;
                                        }
                                        if (!value.contains('@')) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Password',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    TextFormField(
                                      controller: _passwordController,
                                      obscureText: _isObscure,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your password',
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _isObscure = !_isObscure;
                                              });
                                            },
                                            icon: Icon(
                                              _isObscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: AppColors.gray,
                                            )),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return errorEmpty;
                                        }
                                        if (value.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Re-enter password',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    TextFormField(
                                      controller: _confirmPasswordController,
                                      obscureText: _isObscure2,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your password again',
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _isObscure2 = !_isObscure2;
                                              });
                                            },
                                            icon: Icon(
                                              _isObscure2
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: AppColors.gray,
                                            )),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return errorEmpty;
                                        }
                                        if (value.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        if (value != _passwordController.text) {
                                          return 'Password does not match';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: 315.w,
                  child: ElevatedButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(SignUpEvent(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text));
                              }
                            },
                      child: const Text(
                        'Create account',
                      ))),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, AppRouteEnum.loginPage.name);
                  },
                  child: Text('Already have account?',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary))),
            ],
          ));
    });
  }
}
