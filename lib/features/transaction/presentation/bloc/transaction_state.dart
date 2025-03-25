import 'package:equatable/equatable.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';

abstract class TransactionState extends Equatable {
  final List<TransactionEntity> transactions;

  const TransactionState({this.transactions = const []});

  @override
  List<Object?> get props => [transactions];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  const TransactionLoaded({required super.transactions});
}

class TransactionLoadingError extends TransactionState {
  final String message;

  const TransactionLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}

class TransactionAdding extends TransactionState {}

class TransactionAdded extends TransactionState {
  final TransactionEntity addedTransaction;
  TransactionAdded(
      {required this.addedTransaction,
      required List<TransactionEntity> currTransactions})
      : super(transactions: [...currTransactions, addedTransaction]);
}

class TransactionAddingError extends TransactionState {
  final String message;

  const TransactionAddingError({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoadingRequests extends TransactionState {}

class RequestsLoaded extends TransactionState {
  final List<TransactionEntity> requests;

  const RequestsLoaded({required this.requests});

  @override
  List<Object?> get props => [requests];
}

class RequestsLoadingError extends TransactionState {
  final String message;

  const RequestsLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}
