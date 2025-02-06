import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_e_wallet_app/core/params/card_params.dart';
import 'package:paynow_e_wallet_app/features/card/business/usecases/add_card_usecase.dart';
import 'package:paynow_e_wallet_app/features/card/business/usecases/delete_card_usecase.dart';
import 'package:paynow_e_wallet_app/features/card/business/usecases/get_card_usecase.dart';
import 'package:paynow_e_wallet_app/features/card/business/usecases/set_default_usecase.dart';
import 'package:paynow_e_wallet_app/features/card/business/usecases/update_card_usecase.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/bloc/card_event.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/bloc/card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final GetCardUsecase? getCardUsecase;
  final AddCardUsecase? addCardUsecase;
  final UpdateCardUsecase? updateCardUsecase;
  final SetDefaultUsecase? setDefaultUsecase;
  final DeleteCardUsecase? deleteCardUsecase;

  CardBloc(
      {this.getCardUsecase,
      this.addCardUsecase,
      this.updateCardUsecase,
      this.setDefaultUsecase,
      this.deleteCardUsecase})
      : super(CardInitial()) {
    on<GetCardEvent>(_onGetCardEvent);
    on<AddCardEvent>(_onAddCardEvent);
    on<UpdateCardEvent>(_onUpdateCardEvent);
    on<DeleteCardEvent>(_onDeleteCardEvent);
    on<SetDefaultCardEvent>(_onSetDefaultCardEvent);
  }

  _onGetCardEvent(GetCardEvent event, Emitter<CardState> emit) async {
    emit(CardLoading());
    final result = await getCardUsecase!.call(
      event.userId,
    );
    result.fold((l) {
      emit(CardLoadingError(message: l.errorMessage));
    }, (r) {
      emit(CardLoaded(cards: r));
    });
  }

  _onAddCardEvent(AddCardEvent event, Emitter<CardState> emit) async {
    emit(CardAdding());
    final result = await addCardUsecase!.call(
      AddCardParams(event.card),
    );
    result.fold((l) {
      emit(CardAddingError(message: l.errorMessage));
    }, (r) {
      emit(CardAdded(addedCard: r, currCards: state.cards));
    });
  }

  _onUpdateCardEvent(UpdateCardEvent event, Emitter<CardState> emit) async {
    emit(CardUpdating());
    final result = await updateCardUsecase!.call(
      UpdateCardParams(event.card),
    );
    result.fold((l) {
      emit(CardUpdatingError(message: l.errorMessage));
    }, (r) {
      emit(CardUpdated());
    });
  }

  _onDeleteCardEvent(DeleteCardEvent event, Emitter<CardState> emit) async {
    emit(CardDeleting());
    final result = await deleteCardUsecase!.call(event.id);
    result.fold((l) {
      emit(CardDeletingError(message: l.errorMessage));
    }, (r) {
      emit(CardDeleted());
    });
  }

  _onSetDefaultCardEvent(
      SetDefaultCardEvent event, Emitter<CardState> emit) async {
    emit(CardSettingDefault());
    final result = await setDefaultUsecase!.call(
      SetDefaultCardParams(event.card, event.cards),
    );
    result.fold((l) {
      emit(CardSettingDefaultError(message: l.errorMessage));
    }, (r) {
      emit(CardSettedDefault());
    });
  }
}
