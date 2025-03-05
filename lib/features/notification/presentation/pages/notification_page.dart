import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_event.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_state.dart';
import 'package:paynow_e_wallet_app/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:paynow_e_wallet_app/features/notification/presentation/bloc/notification_event.dart';
import 'package:paynow_e_wallet_app/features/notification/presentation/bloc/notification_state.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(GetNotificationEvent(
          userId: context.read<AuthBloc>().state.userEntity!.id!,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final contactBloc = context.watch<ContactBloc>();
    // if (contactBloc.state is FriendRequestResponded) {
    //   context.read<NotificationBloc>().add(GetNotificationEvent(
    //         userId: context.read<AuthBloc>().state.userEntity!.id!,
    //       ));
    // }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notification'),
          centerTitle: true,
        ),
        body: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotificationLoadingError) {
            return Center(child: Text(state.message));
          }
          if (state is NotificationLoaded && state.notifications.isNotEmpty) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.r),
                child: Column(
                  children: [
                    ...state.notifications.map((notification) {
                      if (notification.type ==
                          NotificationType.friendRequest.name) {
                        return FriendRequestItem(
                          onAccept:
                              contactBloc.state is RespondingToFriendRequest
                                  ? null
                                  : () {
                                      // BlocProvider.of<ContactBloc>(context).add(
                                      //     RespondToFriendRequestEvent(
                                      //         requestId:
                                      //             notification.data?['requestId'],
                                      //         senderId:
                                      //             notification.data?['senderId'],
                                      //         accept: true));
                                    },
                          onDecline:
                              contactBloc.state is RespondingToFriendRequest
                                  ? null
                                  : () {
                                      // BlocProvider.of<ContactBloc>(context).add(
                                      //     RespondToFriendRequestEvent(
                                      //         requestId:
                                      //             notification.data?['requestId'],
                                      //         senderId:
                                      //             notification.data?['senderId'],
                                      //         accept: false));
                                    },
                        );
                      }
                      return const SizedBox();
                    })
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Text('No notification'),
          );
        }));
  }
}

class FriendRequestItem extends StatelessWidget {
  const FriendRequestItem({
    super.key,
    required this.onAccept,
    required this.onDecline,
  });
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text.rich(
        TextSpan(
          text: 'John Doe',
          style: TextStyle(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: ' sent you a friend request',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: const Text('test@gmail.com\n2 hours ago'),
      leading: CircleAvatar(
        radius: 25.r,
        backgroundImage: const AssetImage(ImageConstants.defaultUser),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: onAccept,
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: onDecline,
          ),
        ],
      ),
    );
  }
}
