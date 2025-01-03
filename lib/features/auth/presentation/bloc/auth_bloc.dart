import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_e_wallet_app/core/params/auth_params.dart';
import 'package:paynow_e_wallet_app/features/auth/business/usecases/signup_usecase.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase? signUpUsecase;

  AuthBloc({required this.signUpUsecase}) : super(AuthInitial()) {
    on<SignUpEvent>(_onSignUpEvent);
  }

  _onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signUpUsecase!.call(
      SignUpParams(
        email: event.email,
        password: event.password,
      ),
    );
    result.fold((l) {
      emit(Unauthenticated(error: l.errorMessage));
    }, (r) {
      emit(Authenticated(user: r!));
    });
  }
}
