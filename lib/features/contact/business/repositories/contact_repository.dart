import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/contact_params.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';
import 'package:paynow_e_wallet_app/features/contact/business/entities/friend_request_entity.dart';

abstract class ContactRepository {
  Future<Either<Failure, void>> sendFriendRequest(
      SendFriendRequestParams params);
  Future<Either<Failure, void>> respondToFriendRequest(
      ResponseToFrParams params);
  Future<Either<Failure, void>> cancelFriendRequest(CancelFrParams params);
  Future<Either<Failure, void>> unfriend(UnfriendParams params);
  Future<Either<Failure, List<FriendRequestEntity>>> getFriendRequests(
      GetFriendRequestsParams params);
  Future<Either<Failure, List<String>>> getFriends(GetFriendsParams params);
  Future<Either<Failure, List<UserEntity>>> getUserByEmail(
      GetUserByEmailParams params);
  Future<Either<Failure, GetContactStatusResponse>> getContactStatus(
      GetContactStatusParams params);
}
