import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_e_wallet_app/core/params/notificaiton_params.dart';
import 'package:paynow_e_wallet_app/features/notification/business/usecases/del_notification_usecase.dart';
import 'package:paynow_e_wallet_app/features/notification/business/usecases/get_notifications_usecase.dart';
import 'package:paynow_e_wallet_app/features/notification/business/usecases/save_notification_usecase.dart';
import 'package:paynow_e_wallet_app/features/notification/presentation/bloc/notification_event.dart';
import 'package:paynow_e_wallet_app/features/notification/presentation/bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUsecase? getNotificationUsecase;
  final SaveNotificationUsecase? saveNotificationUsecase;
  final DelNotificationUsecase? deleteNotificationUsecase;

  NotificationBloc(
      {this.getNotificationUsecase,
      this.saveNotificationUsecase,
      this.deleteNotificationUsecase})
      : super(NotificationInitial()) {
    on<GetNotificationEvent>(_onGetNotificationEvent);
    on<SaveNotificationEvent>(_onSaveNotificationEvent);
    on<DelNotificationEvent>(_onDeleteNotificationEvent);
  }

  _onGetNotificationEvent(
      GetNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    final result = await getNotificationUsecase!.call(
      GetNotificationsParams(userId: event.userId),
    );
    result.fold((l) {
      emit(NotificationLoadingError(message: l.errorMessage));
    }, (r) {
      emit(NotificationLoaded(notifications: r));
    });
  }

  _onSaveNotificationEvent(
      SaveNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationSaving());
    final result = await saveNotificationUsecase!.call(
      SaveNotificationParams(notification: event.notification),
    );
    result.fold((l) {
      emit(NotificationSavingError(message: l.errorMessage));
    }, (r) {
      emit(const NotificationSaved());
    });
  }

  _onDeleteNotificationEvent(
      DelNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationDeleting());
    final result = await deleteNotificationUsecase!.call(DelNotificationParams(
      notificationId: event.notificationId,
    ));
    result.fold((l) {
      emit(NotificationDeletingError(message: l.errorMessage));
    }, (r) {
      emit(const NotificationDeleted());
    });
  }
}
