import 'package:equatable/equatable.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionEvent extends TransactionEvent {
  final String userId;

  const GetTransactionEvent({required this.userId});
}

class GetRequestsEvent extends TransactionEvent {
  final String userId;

  const GetRequestsEvent({required this.userId});
}

class AddTransactionEvent extends TransactionEvent {
  final TransactionEntity transaction;

  const AddTransactionEvent({required this.transaction});
}

class AcceptRequestEvent extends TransactionEvent {
  final TransactionEntity transaction;

  const AcceptRequestEvent({required this.transaction});
}

class AcceptAllRequestsEvent extends TransactionEvent {
  final List<TransactionEntity> transactions;

  const AcceptAllRequestsEvent({required this.transactions});
}
