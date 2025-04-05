import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/constant.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_event.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_state.dart';
import 'package:paynow_e_wallet_app/features/notification/business/entities/notification_entity.dart';
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
    if (context.watch<NotificationBloc>().state is NotificationDeleted) {
      context.read<NotificationBloc>().add(GetNotificationEvent(
            userId: context.read<AuthBloc>().state.userEntity!.id!,
          ));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notification'),
          centerTitle: true,
        ),
        body: BlocBuilder<NotificationBloc, NotificationState>(
            buildWhen: (previous, current) {
          if (current is NotificationLoaded ||
              current is NotificationLoading ||
              current is NotificationLoadingError) {
            return true;
          }
          return false;
        }, builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotificationLoadingError) {
            return Center(child: Text(state.message));
          }
          if (state is NotificationLoaded && state.notifications.isNotEmpty) {
            if (state.unreadCount > 0) {
              context
                  .read<NotificationBloc>()
                  .add(const UpdNotificationStateEvent(unreadCount: 0));
              for (var i = 0; i < state.notifications.length; i++) {
                context.read<NotificationBloc>().add(UpdNotificationEvent(
                    notificationId: state.notifications[i].id,
                    notification: state.notifications[i].copyWith(
                      isRead: true,
                    )));
              }
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.r),
                child: Column(
                  children: [
                    ...state.notifications.map((notification) {
                      if (notification.type ==
                          NotificationType.friendRequest.name) {
                        return FriendRequestItem(
                          data: notification,
                          onAccept: contactBloc.state
                                  is RespondingToFriendRequest
                              ? null
                              : () {
                                  BlocProvider.of<ContactBloc>(context).add(
                                      RespondToFriendRequestEvent(
                                          receiverId: context
                                              .read<AuthBloc>()
                                              .state
                                              .userEntity!
                                              .id!,
                                          notificationBloc:
                                              context.read<NotificationBloc>(),
                                          requestId:
                                              notification.data?[kRequestId]!,
                                          senderId: notification.senderId!,
                                          accept: true));
                                },
                          onDecline: contactBloc.state
                                  is RespondingToFriendRequest
                              ? null
                              : () {
                                  BlocProvider.of<ContactBloc>(context).add(
                                      RespondToFriendRequestEvent(
                                          receiverId: context
                                              .read<AuthBloc>()
                                              .state
                                              .userEntity!
                                              .id!,
                                          notificationBloc:
                                              context.read<NotificationBloc>(),
                                          requestId:
                                              notification.data![kRequestId]!,
                                          senderId: notification.senderId!,
                                          accept: false));
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
    required this.data,
  });
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final NotificationEntity data;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection(Collection.users.name)
            .doc(data.senderId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return const Center(child: CircularProgressIndicator());
            return const SizedBox();
          }

          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text.rich(
              TextSpan(
                text: snapshot.data?[kName] != null &&
                        snapshot.data?[kName].isNotEmpty
                    ? snapshot.data![kName]
                    : snapshot.data?.id,
                style: const TextStyle(fontWeight: FontWeight.bold),
                children: const [
                  TextSpan(
                    text: ' sent you a friend request',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
                '${snapshot.data?[kEmail]}\n${snapshot.data?[kCreatedAt].toDate().toString().substring(0, 10)}'),
            leading: CircleAvatar(
              radius: 25.r,
              backgroundImage: snapshot.data?[kAvatar] != null &&
                      snapshot.data?[kAvatar].isNotEmpty
                  ? NetworkImage(snapshot.data?[kAvatar])
                  : const AssetImage(ImageConstants.defaultUser),
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
        });
  }
}
