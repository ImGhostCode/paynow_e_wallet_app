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
  final String notificationId;

  const DelNotificationEvent({required this.notificationId});
}
