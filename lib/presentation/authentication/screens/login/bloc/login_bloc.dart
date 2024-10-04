import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';
class LoginBloc extends Bloc<LoginEvents, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailEvents>(_emailEvent);
    on<PasswordEvents>(_passwordEvent);
    on<LoginResetEvent>(_resetEvent);
    on<LoginLoadingEvent>(_handleLoadingEvent);
    on<LoginCredentialsClearedEvent>((event, emit) => emit(state.clearCredentials()));

  }

  void _emailEvent(EmailEvents event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvents event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _resetEvent(LoginResetEvent event, Emitter<LoginState> emit) {
    emit(const LoginState());
  }
  void _handleLoadingEvent(LoginLoadingEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }
  void onSuccessfulLogin(Emitter<LoginState> emit) {
    emit(state.clearCredentials());
  }



}
