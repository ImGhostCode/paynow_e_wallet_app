import 'package:equatable/equatable.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/constant.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';
import 'package:paynow_e_wallet_app/features/contact/business/entities/friend_request_entity.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

// Send friend request
class SendingFriendRequest extends ContactState {}

class FriendRequestSent extends ContactState {
  final ContactStatus contactStatus;
  const FriendRequestSent({required this.contactStatus});
}

class SendingFriendRequestError extends ContactState {
  final String message;

  const SendingFriendRequestError({required this.message});

  @override
  List<Object> get props => [message];
}

// Respond to friend request
class RespondingToFriendRequest extends ContactState {}

class FriendRequestResponded extends ContactState {
  final ContactStatus contactStatus;
  const FriendRequestResponded({required this.contactStatus});
}

class RespondingToFriendRequestError extends ContactState {
  final String message;

  const RespondingToFriendRequestError({required this.message});

  @override
  List<Object> get props => [message];
}

// Cancel friend request
class CancelingFriendRequest extends ContactState {}

class FriendRequestCanceled extends ContactState {
  final ContactStatus contactStatus;
  const FriendRequestCanceled({required this.contactStatus});
}

class CancelingFriendRequestError extends ContactState {
  final String message;

  const CancelingFriendRequestError({required this.message});

  @override
  List<Object> get props => [message];
}

// Unfriend
class Unfriending extends ContactState {}

class Unfriended extends ContactState {
  final ContactStatus contactStatus;
  const Unfriended({required this.contactStatus});
}

class UnfriendingError extends ContactState {
  final String message;

  const UnfriendingError({required this.message});

  @override
  List<Object> get props => [message];
}

// Get friend requests
class LoadingFriendRequests extends ContactState {}

class LoadedFriendRequests extends ContactState {
  final List<FriendRequestEntity> friendRequests;

  const LoadedFriendRequests({required this.friendRequests});

  @override
  List<Object> get props => [friendRequests];
}

class LoadingFriendRequestsError extends ContactState {
  final String message;

  const LoadingFriendRequestsError({required this.message});

  @override
  List<Object> get props => [message];
}

// Get friends
class LoadingFriends extends ContactState {}

class LoadedFriends extends ContactState {
  final List<String> friends;

  const LoadedFriends({required this.friends});

  @override
  List<Object> get props => [friends];
}

class LoadingFriendsError extends ContactState {
  final String message;

  const LoadingFriendsError({required this.message});

  @override
  List<Object> get props => [message];
}

// Get user by email
class LoadingUserByEmail extends ContactState {}

class LoadedUserByEmail extends ContactState {
  final List<UserEntity> users;

  const LoadedUserByEmail({required this.users});

  @override
  List<Object> get props => [users];
}

class LoadingUserByEmailError extends ContactState {
  final String message;

  const LoadingUserByEmailError({required this.message});

  @override
  List<Object> get props => [message];
}

// Get contact status
class LoadingContactStatus extends ContactState {}

class LoadedContactStatus extends ContactState {
  final String? requestId;
  final ContactStatus contactStatus;

  const LoadedContactStatus({required this.contactStatus, this.requestId});

  @override
  List<Object> get props => [contactStatus];
}

class LoadingContactStatusError extends ContactState {
  final String message;

  const LoadingContactStatusError({required this.message});

  @override
  List<Object> get props => [message];
}
