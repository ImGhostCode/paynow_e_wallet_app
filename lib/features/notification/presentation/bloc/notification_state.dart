import 'package:equatable/equatable.dart';
import 'package:paynow_e_wallet_app/features/notification/business/entities/notification_entity.dart';

abstract class NotificationState extends Equatable {
  final List<NotificationEntity> notifications;

  const NotificationState({this.notifications = const []});

  @override
  List<Object?> get props => [notifications];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  const NotificationLoaded({required super.notifications});
}

class NotificationLoadingError extends NotificationState {
  final String message;

  const NotificationLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NotificationSaving extends NotificationState {}

class NotificationSaved extends NotificationState {
  const NotificationSaved();
}

class NotificationSavingError extends NotificationState {
  final String message;

  const NotificationSavingError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NotificationDeleting extends NotificationState {}

class NotificationDeleted extends NotificationState {
  const NotificationDeleted();
}

class NotificationDeletingError extends NotificationState {
  final String message;

  const NotificationDeletingError({required this.message});

  @override
  List<Object?> get props => [message];
}
