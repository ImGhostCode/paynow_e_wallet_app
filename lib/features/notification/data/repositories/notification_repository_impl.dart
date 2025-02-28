import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/exceptions.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/notificaiton_params.dart';
import 'package:paynow_e_wallet_app/features/notification/business/entities/notification_entity.dart';
import 'package:paynow_e_wallet_app/features/notification/business/repositories/notification_repository.dart';
import 'package:paynow_e_wallet_app/features/notification/data/data_sources/noti_remote_data_source.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotiRemoteDataSource notiRemoteDataSource;

  NotificationRepositoryImpl(
    this.notiRemoteDataSource,
  );

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
      GetNotificationsParams params) async {
    try {
      final result = await notiRemoteDataSource.getNotifications(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, void>> saveNotification(
      SaveNotificationParams params) async {
    try {
      final result = await notiRemoteDataSource.saveNotification(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, void>> delNotification(
      DelNotificationParams params) async {
    try {
      final result = await notiRemoteDataSource.delNotification(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }
}
