import 'package:equatable/equatable.dart';
import 'package:paynow_e_wallet_app/features/notification/presentation/bloc/notification_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class SendFriendRequestEvent extends ContactEvent {
  final String senderId;
  final String receiverId;
  final NotificationBloc notificationBloc;

  const SendFriendRequestEvent({
    required this.senderId,
    required this.receiverId,
    required this.notificationBloc,
  });
}

class RespondToFriendRequestEvent extends ContactEvent {
  final String requestId;
  final String senderId;
  final bool accept;
  final NotificationBloc notificationBloc;
  final String receiverId;

  const RespondToFriendRequestEvent({
    required this.notificationBloc,
    required this.receiverId,
    required this.requestId,
    required this.senderId,
    required this.accept,
  });
}

class CancelFriendRequestEvent extends ContactEvent {
  final NotificationBloc notificationBloc;
  final String senderId;
  final String receiverId;

  const CancelFriendRequestEvent(
      {required this.notificationBloc,
      required this.receiverId,
      required this.senderId});
}

class UnfriendEvent extends ContactEvent {
  final String friendId;

  const UnfriendEvent({required this.friendId});
}

class GetFriendRequestsEvent extends ContactEvent {
  final String userId;

  const GetFriendRequestsEvent({required this.userId});
}

class GetFriendsEvent extends ContactEvent {
  final String? userId;

  const GetFriendsEvent({required this.userId});
}

class GetUserByEmailEvent extends ContactEvent {
  final String currUserEmail;
  final String email;

  const GetUserByEmailEvent({required this.email, required this.currUserEmail});
}

class GetContactStatusEvent extends ContactEvent {
  final String userId;
  final String friendId;

  const GetContactStatusEvent({
    required this.userId,
    required this.friendId,
  });
}

class ClearContactStateEvent extends ContactEvent {}
