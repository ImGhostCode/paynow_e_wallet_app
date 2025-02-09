import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_event.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_state.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Contact'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email address',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(13.w)),
                      onPressed: () {
                        if (email.isEmpty) return;

                        BlocProvider.of<ContactBloc>(context)
                            .add(GetUserByEmailEvent(email: email));
                      },
                      child: const Text('Search'))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
                if (state is LoadingUserByEmail) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is LoadingUserByEmailError) {
                  return Center(
                      child: Text(
                    state.message,
                  ));
                }
                if (state is LoadedUserByEmail && state.users.isEmpty) {
                  return const Center(
                      child: Text(
                    'No user found.',
                  ));
                }
                if (state is LoadedUserByEmail) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: state.users[index].avatar.isNotEmpty
                                ? Image.network(
                                    state.users[index].avatar,
                                    height: 40.w,
                                    width: 40.w,
                                  )
                                : Image.asset(
                                    ImageConstants.defaultUser,
                                    height: 40.w,
                                    width: 40.w,
                                  ),
                          ),
                          horizontalTitleGap: 5.w,
                          title: Text(state.users[index].name),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          subtitle: Text(state.users[index].email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.gray)),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.person_add_outlined,
                                  color: AppColors.primaryColor)),
                          onTap: null,
                        );
                      },
                      itemCount: state.users.length);
                }
                return const SizedBox.shrink();
              })
            ],
          ),
        ));
  }
}
