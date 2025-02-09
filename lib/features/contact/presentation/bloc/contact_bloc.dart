import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_e_wallet_app/core/params/contact_params.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/cancel_fr_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/get_friend_requests_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/get_friends_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/get_user_by_email_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/response_to_fr_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/send_fr_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/unfriend_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_event.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final SendFriendRequestUsecase? sendFriendRequestUsecase;
  final ResponseToFrUsecase? responseToFrUsecase;
  final CancelFrUsecase? cancelFrUsecase;
  final UnfriendUsecase? unfriendUsecase;
  final GetFriendRequestsUsecase? getFriendRequestsUsecase;
  final GetFriendsUsecase? getFriendsUsecase;
  final GetUserByEmailUsecase? getUserByEmailUsecase;

  ContactBloc({
    this.sendFriendRequestUsecase,
    this.responseToFrUsecase,
    this.cancelFrUsecase,
    this.unfriendUsecase,
    this.getFriendRequestsUsecase,
    this.getFriendsUsecase,
    this.getUserByEmailUsecase,
  }) : super(ContactInitial()) {
    on<SendFriendRequestEvent>(_onSendFriendRequestEvent);
    on<RespondToFriendRequestEvent>(_onRespondToFriendRequestEvent);
    on<CancelFriendRequestEvent>(_onCancelFriendRequestEvent);
    on<UnfriendEvent>(_onUnfriendEvent);
    on<GetFriendRequestsEvent>(_onGetFriendRequestsEvent);
    on<GetFriendsEvent>(_onGetFriendsEvent);
    on<GetUserByEmailEvent>(_onGetUserByEmailEvent);
  }

  _onSendFriendRequestEvent(
      SendFriendRequestEvent event, Emitter<ContactState> emit) async {
    emit(SendingFriendRequest());
    final result = await sendFriendRequestUsecase!.call(
      SendFriendRequestParams(
        receiverId: event.receiverId,
      ),
    );
    result.fold((l) {
      emit(SendingFriendRequestError(message: l.errorMessage));
    }, (r) {
      emit(FriendRequestSent());
    });
  }

  _onRespondToFriendRequestEvent(
      RespondToFriendRequestEvent event, Emitter<ContactState> emit) async {
    emit(RespondingToFriendRequest());
    final result = await responseToFrUsecase!.call(
      ResponseToFrParams(
        requestId: event.requestId,
        senderId: event.senderId,
        accept: event.accept,
      ),
    );
    result.fold((l) {
      emit(RespondingToFriendRequestError(message: l.errorMessage));
    }, (r) {
      emit(FriendRequestResponded());
    });
  }

  _onCancelFriendRequestEvent(
      CancelFriendRequestEvent event, Emitter<ContactState> emit) async {
    emit(CancelingFriendRequest());
    final result = await cancelFrUsecase!.call(
      CancelFrParams(
        receiverId: event.receiverId,
      ),
    );
    result.fold((l) {
      emit(CancelingFriendRequestError(message: l.errorMessage));
    }, (r) {
      emit(FriendRequestCanceled());
    });
  }

  _onUnfriendEvent(UnfriendEvent event, Emitter<ContactState> emit) async {
    emit(Unfriending());
    final result = await unfriendUsecase!.call(
      UnfriendParams(
        friendId: event.friendId,
      ),
    );
    result.fold((l) {
      emit(UnfriendingError(message: l.errorMessage));
    }, (r) {
      emit(Unfriended());
    });
  }

  _onGetFriendRequestsEvent(
      GetFriendRequestsEvent event, Emitter<ContactState> emit) async {
    emit(LoadingFriendRequests());
    final result = await getFriendRequestsUsecase!.call(
      GetFriendRequestsParams(
        userId: event.userId,
      ),
    );
    result.fold((l) {
      emit(LoadingFriendRequestsError(message: l.errorMessage));
    }, (r) {
      emit(LoadedFriendRequests(friendRequests: r));
    });
  }

  _onGetFriendsEvent(GetFriendsEvent event, Emitter<ContactState> emit) async {
    emit(LoadingFriends());
    final result = await getFriendsUsecase!.call(
      GetFriendsParams(
        userId: event.userId,
      ),
    );
    result.fold((l) {
      emit(LoadingFriendsError(message: l.errorMessage));
    }, (r) {
      emit(LoadedFriends(friends: r));
    });
  }

  _onGetUserByEmailEvent(
      GetUserByEmailEvent event, Emitter<ContactState> emit) async {
    emit(LoadingUserByEmail());
    final result = await getUserByEmailUsecase!.call(
      GetUserByEmailParams(
        email: event.email,
      ),
    );
    result.fold((l) {
      emit(LoadingUserByEmailError(message: l.errorMessage));
    }, (r) {
      emit(LoadedUserByEmail(users: r));
    });
  }
}
