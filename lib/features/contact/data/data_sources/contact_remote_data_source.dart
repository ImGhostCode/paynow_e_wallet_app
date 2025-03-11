import 'package:paynow_e_wallet_app/core/params/contact_params.dart';
import 'package:paynow_e_wallet_app/features/auth/data/models/user_model.dart';
import 'package:paynow_e_wallet_app/features/contact/data/models/friend_request_model.dart';

abstract class ContactRemoteDataSource {
  Future<String> sendFriendRequest(SendFriendRequestParams params);
  Future<void> respondToFriendRequest(ResponseToFrParams params);
  Future<void> cancelFriendRequest(CancelFrParams params);
  Future<void> unfriend(UnfriendParams params);
  Future<List<FriendRequestModel>> getFriendRequests(
      GetFriendRequestsParams params);
  Future<List<UserModel>> getFriends(GetFriendsParams params);
  Future<List<UserModel>> getUserByEmail(GetUserByEmailParams params);
  Future<GetContactStatusResponse> getContactStatus(
      GetContactStatusParams params);
}
