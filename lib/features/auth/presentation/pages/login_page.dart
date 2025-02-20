import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/core/helper/notification_service.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/app_constants.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(buildWhen: (previous, current) {
      return current is AuthLoading ||
          current is Authenticated ||
          current is Unauthenticated;
    }, listener: (context, state) {
      if (state is Authenticated) {
        sl<NotificationService>().saveFCMToken(state.userEntity?.id);
        Helper.showSnackBar(message: 'Login up successfully', isSuccess: true);
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouteEnum.homePage.name,
          (route) => false,
        );
      } else if (state is Unauthenticated) {
        Helper.showSnackBar(message: state.error);
      }
    }, builder: (context, state) {
      return Scaffold(
          body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                ImageConstants.background,
                fit: BoxFit.fill,
              ),
            ),
            Form(
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
                        'Login and start transfering',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontWeight: FontWeight.bold),
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
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w400),
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
                                    .copyWith(fontWeight: FontWeight.w400),
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
                                  return null;
                                },
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot password?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 315.w,
                            child: ElevatedButton(
                                onPressed: state.runtimeType == AuthLoading
                                    ? null
                                    : () => _handleLogin(context),
                                child: const Text(
                                  'Login',
                                )),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, AppRouteEnum.signupPage.name);
                              },
                              child: Text('Create new account',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ));
    });
  }

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginEvent(
          email: _emailController.text, password: _passwordController.text));
    }
  }
}
