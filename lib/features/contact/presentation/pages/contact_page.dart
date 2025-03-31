import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_event.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_state.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final TextEditingController _searchController = TextEditingController();
  List<UserEntity> _filteredFriends = [];
  List<UserEntity> _allFriends = [];

  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().add(GetFriendsEvent(
          userId: context.read<AuthBloc>().state.userEntity?.id,
        ));
  }

  void _filterFriends(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredFriends = _allFriends;
      } else {
        print('test@gmail.com'.contains(query));
        print('test'.contains(query));
        _filteredFriends = _allFriends
            .where((friend) =>
                friend.name.toLowerCase().contains(query.toLowerCase()) ||
                friend.email.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

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
                onPressed: () {
                  Navigator.pushNamed(
                      context, AppRouteEnum.addContactPage.name);
                },
              ),
              SizedBox(width: 10.w),
            ],
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(2.h), child: const Divider()),
          ),
        ),
        body: BlocBuilder<ContactBloc, ContactState>(
            buildWhen: (previous, current) {
          if (current is LoadingFriends ||
              current is LoadedFriends ||
              current is LoadingFriendsError) {
            return true;
          }
          return false;
        }, builder: (context, state) {
          if (state is LoadingFriends) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LoadingFriendsError) {
            return Center(child: Text(state.message));
          }

          if (state is LoadedFriends && state.friends.isEmpty) {
            return const Center(child: Text('No friends'));
          }
          if (state is LoadedFriends) {
            _allFriends = state.friends;
            _filteredFriends =
                _filteredFriends.isEmpty && _searchController.text.isEmpty
                    ? _allFriends
                    : _filteredFriends;

            return RefreshIndicator(
              onRefresh: () {
                _allFriends.clear();
                _filteredFriends.clear();
                context.read<ContactBloc>().add(GetFriendsEvent(
                      userId: context.read<AuthBloc>().state.userEntity?.id,
                    ));
                return Future.delayed(const Duration(seconds: 1));
              },
              child: Padding(
                padding: EdgeInsets.all(15.r),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: _filterFriends,
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
                    Expanded(
                      child: _filteredFriends.isEmpty
                          ? const Center(child: Text('No friends found'))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  contentPadding: EdgeInsets.zero,
                                  leading: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: _filteredFriends[index]
                                            .avatar
                                            .isNotEmpty
                                        ? Image.network(
                                            _filteredFriends[index].avatar,
                                            height: 40.w,
                                            width: 40.w,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            ImageConstants.defaultUser,
                                            height: 40.w,
                                            width: 40.w,
                                          ),
                                  ),
                                  horizontalTitleGap: 5.w,
                                  title: Text(
                                    _filteredFriends[index].name.isNotEmpty
                                        ? _filteredFriends[index].name
                                        : _filteredFriends[index].id!,
                                  ),
                                  titleTextStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  subtitle: Text(_filteredFriends[index].email,
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
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  AppRouteEnum
                                                      .sendMoneyPage.name,
                                                  arguments:
                                                      _filteredFriends[index]);
                                            },
                                            child: SvgPicture.asset(
                                                ImageConstants.send,
                                                height: 20.w,
                                                width: 20.w)),
                                      ),
                                      SizedBox(width: 8.w),
                                      SizedBox(
                                        height: 40.h,
                                        width: 40.w,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  AppRouteEnum
                                                      .requestMoneyPage.name,
                                                  arguments:
                                                      _filteredFriends[index]);
                                            },
                                            child: SvgPicture.asset(
                                                ImageConstants.request,
                                                height: 20.w,
                                                width: 20.w)),
                                      ),
                                    ],
                                  ),
                                  onTap: () {},
                                );
                              },
                              itemCount: _filteredFriends.length),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }));
  }
}

// Contact page: Lấy danh sách contact từ các giao dịch trước đó
// Send money: Chọn từ contacts hoặc nhập email

// Kết bạn
// Send money từ contacts
