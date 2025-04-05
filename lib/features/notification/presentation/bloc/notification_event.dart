import 'package:equatable/equatable.dart';
import 'package:paynow_e_wallet_app/features/notification/business/entities/notification_entity.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationEvent extends NotificationEvent {
  final String userId;

  const GetNotificationEvent({required this.userId});
}

class SaveNotificationEvent extends NotificationEvent {
  final NotificationEntity notification;

  const SaveNotificationEvent({required this.notification});
}

class DelNotificationEvent extends NotificationEvent {
  final String? notificationId;
  final String? senderId;
  final String? receiverId;
  final String? type;

  const DelNotificationEvent(
      {this.notificationId, this.senderId, this.receiverId, this.type});
}

class UpdNotificationEvent extends NotificationEvent {
  final String? notificationId;
  final NotificationEntity notification;

  const UpdNotificationEvent({this.notificationId, required this.notification});
}

class NewNotificationReceived extends NotificationEvent {
  final String? type;

  const NewNotificationReceived({
    required this.type,
  });
}

class UpdNotificationStateEvent extends NotificationEvent {
  final int? unreadCount;
  final int? moneyRequestCount;

  const UpdNotificationStateEvent({this.unreadCount, this.moneyRequestCount});
}
