import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';

class SendFriendRequestParams {
  final String receiverId;

  SendFriendRequestParams({
    required this.receiverId,
  });
}

class ResponseToFrParams {
  final String requestId;
  final String senderId;
  final bool accept;

  ResponseToFrParams({
    required this.requestId,
    required this.senderId,
    required this.accept,
  });
}

class CancelFrParams {
  final String receiverId;

  CancelFrParams({
    required this.receiverId,
  });
}

class UnfriendParams {
  final String friendId;

  UnfriendParams({
    required this.friendId,
  });
}

class GetFriendRequestsParams {
  final String userId;

  GetFriendRequestsParams({
    required this.userId,
  });
}

class GetFriendsParams {
  final String userId;

  GetFriendsParams({
    required this.userId,
  });
}

class GetUserByEmailParams {
  final String currUserEmail;
  final String email;

  GetUserByEmailParams({
    required this.currUserEmail,
    required this.email,
  });
}

class GetContactStatusParams {
  final String userId;
  final String friendId;

  GetContactStatusParams({
    required this.userId,
    required this.friendId,
  });
}

class GetContactStatusResponse {
  final String? requestId;
  final ContactStatus contactStatus;

  GetContactStatusResponse({
    this.requestId,
    required this.contactStatus,
  });
}
