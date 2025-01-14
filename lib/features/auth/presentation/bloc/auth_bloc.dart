import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynow_e_wallet_app/core/params/auth_params.dart';
import 'package:paynow_e_wallet_app/features/auth/business/usecases/get_user_usecase.dart';
import 'package:paynow_e_wallet_app/features/auth/business/usecases/login_usecase.dart';
import 'package:paynow_e_wallet_app/features/auth/business/usecases/signup_usecase.dart';
import 'package:paynow_e_wallet_app/features/auth/business/usecases/update_user_usecase.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase? signUpUsecase;
  final LoginUsecase? loginUsecase;
  final GetUserUsecase? getUserUsecase;
  final UpdateUserUsecase? updateUserUsecase;

  AuthBloc(
      {this.getUserUsecase,
      this.signUpUsecase,
      this.loginUsecase,
      this.updateUserUsecase})
      : super(AuthInitial()) {
    on<SignUpEvent>(_onSignUpEvent);
    on<LoginEvent>(_onLoginEvent);
    on<GetUserEvent>(_onGetUserEvent);
    on<UpdateUserEvent>(_onUpdateUserEvent);
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

  _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUsecase!.call(
      LoginParams(
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

  _onGetUserEvent(GetUserEvent event, Emitter<AuthState> emit) async {
    emit(const IsLoadingUser());
    final result = await getUserUsecase!.call(event.id);
    result.fold((l) {
      emit(ErrorLoadingUser(error: l.errorMessage));
    }, (r) {
      emit(LoadedUser(userEntity: r!));
    });
  }

  _onUpdateUserEvent(UpdateUserEvent event, Emitter<AuthState> emit) async {
    emit(const IsUpdatingUser());
    final result = await updateUserUsecase!.call(event.params);
    result.fold((l) {
      emit(ErrorUpdatingUser(error: l.errorMessage));
    }, (r) {
      add(GetUserEvent(id: event.params.id));
      emit(const UpdatedUser());
    });
  }
}
