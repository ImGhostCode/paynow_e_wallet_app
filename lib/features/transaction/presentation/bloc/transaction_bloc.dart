import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_e_wallet_app/core/helper/notification_service.dart';
import 'package:paynow_e_wallet_app/core/params/transaction_params.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/constant.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/usecases/accept_all_requests_usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/usecases/accept_request_usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/usecases/add_transactions_usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/usecases/get_requests_usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/usecases/get_transactions_usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactionsUsecase? getTransactionUsecase;
  final AddTransactionUsecase? addTransactionUsecase;
  final GetRequestsUsecase? getRequestsUsecase;
  final AcceptRequestUsecase? acceptRequestUsecase;
  final AcceptAllRequestsUsecase? acceptAllRequestsUsecase;

  TransactionBloc(
      {this.getTransactionUsecase,
      this.addTransactionUsecase,
      this.getRequestsUsecase,
      this.acceptRequestUsecase,
      this.acceptAllRequestsUsecase})
      : super(TransactionInitial()) {
    on<GetTransactionEvent>(_onGetTransactionEvent);
    on<AddTransactionEvent>(_onAddTransactionEvent);
    on<GetRequestsEvent>(_onGetRequestsEvent);
    on<AcceptRequestEvent>(_onAcceptRequestEvent);
    on<AcceptAllRequestsEvent>(_onAcceptAllRequestsEvent);
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

  _onGetRequestsEvent(
      GetRequestsEvent event, Emitter<TransactionState> emit) async {
    emit(LoadingRequests());
    final result = await getRequestsUsecase!.call(
      event.userId,
    );
    result.fold((l) {
      emit(RequestsLoadingError(message: l.errorMessage));
    }, (r) {
      emit(RequestsLoaded(requests: r));
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
    }, (r) async {
      emit(TransactionAdded(
          addedTransaction: r, currTransactions: state.transactions));
      final token = await sl<NotificationService>()
          .getDeviceToken(event.transaction.receiverId);
      if (token != null && token.isNotEmpty) {
        sl<NotificationService>().sendNotification(
            deviceToken: token,
            title: event.transaction.transactionType ==
                    TransactionType.request.name
                ? 'Money transfer request'
                : 'Money transfer',
            body: event.transaction.transactionType ==
                    TransactionType.request.name
                ? 'You have a new money transfer request for \$${event.transaction.amount}'
                : 'You have received \$${event.transaction.amount} from ${event.transaction.senderId}',
            data: {
              'type': event.transaction.transactionType ==
                      TransactionType.request.name
                  ? NotificationType.requestMoney.name
                  : NotificationType.receivedMoney.name,
              'senderId': event.transaction.senderId,
              'receiverId': event.transaction.receiverId,
            });
      }
    });
  }

  _onAcceptRequestEvent(
      AcceptRequestEvent event, Emitter<TransactionState> emit) async {
    emit(AcceptingRequest());
    final result = await acceptRequestUsecase!.call(
      AcceptRequestParams(event.transaction),
    );
    result.fold((l) {
      emit(RequestAcceptingError(
        message: l.errorMessage,
      ));
    }, (r) async {
      emit(RequestAccepted());
      final token = await sl<NotificationService>()
          .getDeviceToken(event.transaction.senderId);
      if (token != null && token.isNotEmpty) {
        sl<NotificationService>().sendNotification(
            deviceToken: token,
            title: 'Money transfer request is accepted',
            body:
                '${event.transaction.receiverId} accepted your money transfer request for \$${event.transaction.amount}',
            data: {
              'type': NotificationType.acceptedMoneyRequest.name,
              'senderId': event.transaction.senderId,
              'receiverId': event.transaction.receiverId,
            });
      }
    });
  }

  _onAcceptAllRequestsEvent(
      AcceptAllRequestsEvent event, Emitter<TransactionState> emit) async {
    emit(AcceptingAllRequests());
    final result = await acceptAllRequestsUsecase!.call(
      AcceptAllRequestParams(event.transactions),
    );
    result.fold((l) {
      emit(AllRequestsAcceptingError(
        message: l.errorMessage,
      ));
    }, (r) {
      emit(AllRequestsAccepted());
    });
  }
}
