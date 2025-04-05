import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_e_wallet_app/core/params/notificaiton_params.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';
import 'package:paynow_e_wallet_app/features/notification/business/usecases/del_notification_usecase.dart';
import 'package:paynow_e_wallet_app/features/notification/business/usecases/get_notifications_usecase.dart';
import 'package:paynow_e_wallet_app/features/notification/business/usecases/save_notification_usecase.dart';
import 'package:paynow_e_wallet_app/features/notification/business/usecases/upd_notification_usecase.dart';
import 'package:paynow_e_wallet_app/features/notification/presentation/bloc/notification_event.dart';
import 'package:paynow_e_wallet_app/features/notification/presentation/bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUsecase? getNotificationUsecase;
  final SaveNotificationUsecase? saveNotificationUsecase;
  final DelNotificationUsecase? deleteNotificationUsecase;
  final UpdNotificationUsecase? updNotificationUsecase;

  NotificationBloc(
      {this.getNotificationUsecase,
      this.saveNotificationUsecase,
      this.deleteNotificationUsecase,
      this.updNotificationUsecase})
      : super(NotificationInitial()) {
    on<GetNotificationEvent>(_onGetNotificationEvent);
    on<SaveNotificationEvent>(_onSaveNotificationEvent);
    on<DelNotificationEvent>(_onDeleteNotificationEvent);
    on<NewNotificationReceived>(_onNewNotificationReceived);
    on<UpdNotificationEvent>(_onUpdNotificationEvent);
    on<UpdNotificationStateEvent>(_updateNumberOfUnreadNotifications);
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
      emit(NotificationLoaded(
        notifications: r,
        unreadCount: r.where((n) => n.isRead == false).length,
      ));
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

  _onUpdNotificationEvent(
      UpdNotificationEvent event, Emitter<NotificationState> emit) async {
    // emit(NotificationUpdating());
    final result = await updNotificationUsecase!.call(
      UpdateNotificationParams(
          notificationId: event.notificationId,
          notification: event.notification),
    );
    result.fold((l) {
      // emit(NotificationUpdatingError(message: l.errorMessage));
    }, (r) {
      // emit(const NotificationUpdated());
    });
  }

  _onDeleteNotificationEvent(
      DelNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationDeleting());
    final result = await deleteNotificationUsecase!.call(DelNotificationParams(
      notificationId: event.notificationId,
      senderId: event.senderId,
      receiverId: event.receiverId,
      type: event.type,
    ));
    result.fold((l) {
      emit(NotificationDeletingError(message: l.errorMessage));
    }, (r) {
      emit(const NotificationDeleted());
    });
  }

  _onNewNotificationReceived(
      NewNotificationReceived event, Emitter<NotificationState> emit) {
    if (event.type == null) return;
    if (state is! NotificationLoaded) {
      emit(const NotificationLoaded(
        notifications: [],
        unreadCount: 0,
        moneyRequestCount: 0,
      ));
    }
    int newUnreadCount = state.unreadCount;
    int moneyRequestCount = state.moneyRequestCount;
    if (event.type == NotificationType.friendRequest.name) {
      newUnreadCount++;
    } else if (event.type == NotificationType.requestMoney.name) {
      moneyRequestCount++;
    }
    emit(NotificationLoaded(
      notifications: state.notifications,
      unreadCount: newUnreadCount,
      moneyRequestCount: moneyRequestCount,
    ));
  }

  _updateNumberOfUnreadNotifications(
      UpdNotificationStateEvent event, Emitter<NotificationState> emit) {
    if (state is! NotificationLoaded) {
      emit(const NotificationLoaded(
        notifications: [],
        unreadCount: 0,
        moneyRequestCount: 0,
      ));
    }
    if (state is NotificationLoaded) {
      emit(NotificationLoaded(
        notifications: state.notifications,
        unreadCount: event.unreadCount ?? state.unreadCount,
        moneyRequestCount: event.moneyRequestCount ?? state.moneyRequestCount,
      ));
    }
  }
}
