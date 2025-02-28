import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/notificaiton_params.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/notification/business/repositories/notification_repository.dart';

class SaveNotificationUsecase extends UseCase<void, SaveNotificationParams> {
  final NotificationRepository repository;

  SaveNotificationUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveNotificationParams params) async {
    final result = await repository.saveNotification(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
