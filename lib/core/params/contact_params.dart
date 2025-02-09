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
  final String email;

  GetUserByEmailParams({
    required this.email,
  });
}
