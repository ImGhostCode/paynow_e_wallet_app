import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/constant.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
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

                        BlocProvider.of<ContactBloc>(context).add(
                            GetUserByEmailEvent(
                                currUserEmail: context
                                    .read<AuthBloc>()
                                    .state
                                    .userEntity!
                                    .email,
                                email: email));
                      },
                      child: const Text('Search'))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              BlocBuilder<ContactBloc, ContactState>(
                  buildWhen: (previous, current) {
                if (current is LoadingUserByEmail ||
                    current is LoadingUserByEmailError ||
                    current is LoadedUserByEmail) {
                  return true;
                }
                return false;
              }, builder: (context, state) {
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
                          title: Text(
                            state.users[index].name.isNotEmpty
                                ? state.users[index].name
                                : state.users[index].id!,
                          ),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          subtitle: Text(state.users[index].email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.gray)),
                          trailing: BlocBuilder(
                              bloc: context.read<ContactBloc>()
                                ..add(GetContactStatusEvent(
                                    userId: context
                                        .read<AuthBloc>()
                                        .state
                                        .userEntity!
                                        .id!,
                                    friendId: state.users[index].id!)),
                              builder: (context, statusState) {
                                if (statusState is LoadingContactStatus) {
                                  return const CircularProgressIndicator();
                                }
                                if (statusState is LoadedContactStatus) {
                                  if (statusState.contactStatus ==
                                      ContactStatus.pending) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(getIconByStatus(
                                              statusState.contactStatus)),
                                          onPressed: () {
                                            _respondToFriendRequest(
                                                context: context,
                                                requestId:
                                                    statusState.requestId!,
                                                senderId:
                                                    state.users[index].id!,
                                                accept: true);
                                          },
                                        ),
                                        IconButton(
                                          icon:
                                              const Icon(Icons.cancel_outlined),
                                          onPressed: () {
                                            _respondToFriendRequest(
                                                context: context,
                                                requestId:
                                                    statusState.requestId!,
                                                senderId:
                                                    state.users[index].id!,
                                                accept: false);
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                  return IconButton(
                                    icon: Icon(getIconByStatus(
                                        statusState.contactStatus)),
                                    onPressed: () async {
                                      if (statusState.contactStatus ==
                                          ContactStatus.sent) {
                                        _cancelFriendRequest(
                                            context: context,
                                            receiverId: state.users[index].id!);
                                      } else if (statusState.contactStatus ==
                                          ContactStatus.accepted) {
                                        _unfriend(
                                            context: context,
                                            friendId: state.users[index].id!);
                                      } else {
                                        _sendFriendRequest(
                                            context: context,
                                            receiverId: state.users[index].id!);
                                      }
                                    },
                                  );
                                }

                                if (statusState is FriendRequestSent) {
                                  return IconButton(
                                      onPressed: () {
                                        _cancelFriendRequest(
                                            context: context,
                                            receiverId: state.users[index].id!);
                                      },
                                      icon: Icon(getIconByStatus(
                                          statusState.contactStatus)));
                                }

                                if (statusState is FriendRequestCanceled) {
                                  return IconButton(
                                      onPressed: () {
                                        _sendFriendRequest(
                                            context: context,
                                            receiverId: state.users[index].id!);
                                      },
                                      icon: Icon(getIconByStatus(
                                          statusState.contactStatus)));
                                }

                                if (statusState is FriendRequestResponded) {
                                  return IconButton(
                                      onPressed: () {
                                        if (statusState.contactStatus ==
                                            ContactStatus.accepted) {
                                          _unfriend(
                                              context: context,
                                              friendId: state.users[index].id!);
                                        } else {
                                          _sendFriendRequest(
                                              context: context,
                                              receiverId:
                                                  state.users[index].id!);
                                        }
                                      },
                                      icon: Icon(getIconByStatus(
                                          statusState.contactStatus)));
                                }

                                if (statusState is Unfriended) {
                                  return IconButton(
                                      onPressed: () {
                                        _sendFriendRequest(
                                            context: context,
                                            receiverId: state.users[index].id!);
                                      },
                                      icon: Icon(getIconByStatus(
                                          statusState.contactStatus)));
                                }
                                return const SizedBox.shrink();
                              }),
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

  void _respondToFriendRequest(
      {required BuildContext context,
      required String requestId,
      required String senderId,
      required bool accept}) {
    BlocProvider.of<ContactBloc>(context).add(RespondToFriendRequestEvent(
        requestId: requestId, senderId: senderId, accept: accept));
  }

  void _sendFriendRequest(
      {required BuildContext context, required String receiverId}) {
    BlocProvider.of<ContactBloc>(context).add(SendFriendRequestEvent(
        // senderId: context
        //     .read<AuthBloc>()
        //     .state
        //     .userEntity!
        //     .id!,
        receiverId: receiverId));
  }

  void _unfriend({required BuildContext context, required String friendId}) {
    BlocProvider.of<ContactBloc>(context)
        .add(UnfriendEvent(friendId: friendId));
  }

  void _cancelFriendRequest(
      {required BuildContext context, required String receiverId}) {
    BlocProvider.of<ContactBloc>(context).add(CancelFriendRequestEvent(
        senderId: context.read<AuthBloc>().state.userEntity!.id!,
        receiverId: receiverId));
  }

  IconData getIconByStatus(ContactStatus status) {
    switch (status) {
      case ContactStatus.sent:
        return Icons.cancel;
      case ContactStatus.accepted:
        return Icons.person_remove;
      case ContactStatus.pending:
        return Icons.check;
      default:
        return Icons.person_add_outlined;
    }
  }
}
