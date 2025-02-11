import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/exceptions.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/contact_params.dart';
import 'package:paynow_e_wallet_app/features/auth/data/models/user_model.dart';
import 'package:paynow_e_wallet_app/features/contact/business/entities/friend_request_entity.dart';
import 'package:paynow_e_wallet_app/features/contact/business/repositories/contact_repository.dart';
import 'package:paynow_e_wallet_app/features/contact/data/data_sources/contact_remote_data_source.dart';

class ContactRepositoryImpl extends ContactRepository {
  final ContactRemoteDataSource contactRemoteDataSource;

  ContactRepositoryImpl(
    this.contactRemoteDataSource,
  );

  @override
  Future<Either<Failure, void>> cancelFriendRequest(
      CancelFrParams params) async {
    try {
      final result = await contactRemoteDataSource.cancelFriendRequest(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, List<FriendRequestEntity>>> getFriendRequests(
      GetFriendRequestsParams params) async {
    try {
      final result = await contactRemoteDataSource.getFriendRequests(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getFriends(
      GetFriendsParams params) async {
    try {
      final result = await contactRemoteDataSource.getFriends(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, void>> respondToFriendRequest(
      ResponseToFrParams params) async {
    try {
      final result =
          await contactRemoteDataSource.respondToFriendRequest(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, void>> sendFriendRequest(
      SendFriendRequestParams params) async {
    try {
      final result = await contactRemoteDataSource.sendFriendRequest(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, void>> unfriend(UnfriendParams params) async {
    try {
      final result = await contactRemoteDataSource.unfriend(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUserByEmail(
      GetUserByEmailParams params) async {
    try {
      final result = await contactRemoteDataSource.getUserByEmail(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, GetContactStatusResponse>> getContactStatus(
      GetContactStatusParams params) async {
    try {
      final result = await contactRemoteDataSource.getContactStatus(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }
}
