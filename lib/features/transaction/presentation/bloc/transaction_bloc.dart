import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_e_wallet_app/core/params/transaction_params.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/usecases/add_transactions_usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/usecases/get_transactions_usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactionsUsecase? getTransactionUsecase;
  final AddTransactionUsecase? addTransactionUsecase;

  TransactionBloc({this.getTransactionUsecase, this.addTransactionUsecase})
      : super(TransactionInitial()) {
    on<GetTransactionEvent>(_onGetTransactionEvent);
    on<AddTransactionEvent>(_onAddTransactionEvent);
  }

  _onGetTransactionEvent(
      GetTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    final result = await getTransactionUsecase!.call(
      event.userId,
    );
    result.fold((l) {
      emit(TransactionLoadingError(message: l.errorMessage));
    }, (r) {
      emit(TransactionLoaded(transactions: r));
    });
  }

  _onAddTransactionEvent(
      AddTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionAdding());
    final result = await addTransactionUsecase!.call(
      AddTransactionParams(event.transaction),
    );
    result.fold((l) {
      emit(TransactionAddingError(message: l.errorMessage));
    }, (r) {
      emit(TransactionAdded(
          addedTransaction: r, currTransactions: state.transactions));
    });
  }
}
