import 'package:equatable/equatable.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';

abstract class TransactionState extends Equatable {
  final List<TransactionEntity> transactions;
  final List<TransactionEntity> requests;

  const TransactionState(
      {this.transactions = const [], this.requests = const []});

  @override
  List<Object?> get props => [transactions, requests];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {
  const TransactionLoading({super.requests, super.transactions});
}

class TransactionLoaded extends TransactionState {
  const TransactionLoaded({required super.transactions, super.requests});
}

class TransactionLoadingError extends TransactionState {
  final String message;

  const TransactionLoadingError(
      {required this.message, super.requests, super.transactions});

  @override
  List<Object?> get props => [message, transactions, requests];
}

class TransactionAdding extends TransactionState {
  const TransactionAdding({super.requests, super.transactions});
}

class TransactionAdded extends TransactionState {
  final TransactionEntity addedTransaction;
  TransactionAdded(
      {required this.addedTransaction,
      required List<TransactionEntity> currTransactions,
      super.requests})
      : super(
          transactions: [...currTransactions, addedTransaction],
        );
}

class TransactionAddingError extends TransactionState {
  final String message;

  const TransactionAddingError(
      {required this.message, super.transactions, super.requests});

  @override
  List<Object?> get props => [message, transactions, requests];
}

class LoadingRequests extends TransactionState {
  const LoadingRequests({super.requests, super.transactions});
}

class RequestsLoaded extends TransactionState {
  const RequestsLoaded({required super.requests, super.transactions});
}

class RequestsLoadingError extends TransactionState {
  final String message;

  const RequestsLoadingError(
      {required this.message, super.requests, super.transactions});

  @override
  List<Object?> get props => [message, transactions, requests];
}

class AcceptingRequest extends TransactionState {
  const AcceptingRequest({super.transactions, super.requests});
}

class RequestAccepted extends TransactionState {
  const RequestAccepted({super.transactions, super.requests});
}

class RequestAcceptingError extends TransactionState {
  final String message;

  const RequestAcceptingError(
      {required this.message, super.requests, super.transactions});

  @override
  List<Object?> get props => [message, transactions, requests];
}

class AcceptingAllRequests extends TransactionState {
  const AcceptingAllRequests({super.requests, super.transactions});
}

class AllRequestsAccepted extends TransactionState {
  const AllRequestsAccepted({super.requests, super.transactions});
}

class AllRequestsAcceptingError extends TransactionState {
  final String message;

  const AllRequestsAcceptingError(
      {required this.message, super.requests, super.transactions});

  @override
  List<Object?> get props => [message, transactions, requests];
}
