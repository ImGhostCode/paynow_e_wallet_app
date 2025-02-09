import 'package:equatable/equatable.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class SendFriendRequestEvent extends ContactEvent {
  final String receiverId;

  const SendFriendRequestEvent({required this.receiverId});
}

class RespondToFriendRequestEvent extends ContactEvent {
  final String requestId;
  final String senderId;
  final bool accept;

  const RespondToFriendRequestEvent({
    required this.requestId,
    required this.senderId,
    required this.accept,
  });
}

class CancelFriendRequestEvent extends ContactEvent {
  final String receiverId;

  const CancelFriendRequestEvent({required this.receiverId});
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
  final String userId;

  const GetFriendsEvent({required this.userId});
}

class GetUserByEmailEvent extends ContactEvent {
  final String email;

  const GetUserByEmailEvent({required this.email});
}
