import 'package:fitfoot/presentation/authentication/screens/register/bloc/register_event.dart';
import 'package:fitfoot/presentation/authentication/screens/register/bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<EmailEvent>(_emailEvent);
    on<NameEvent>(_nameEvent);
    on<PasswordEvent>(_passwordEvent);
    on<RePasswordEvent>(_rePasswordEvent);
    on<ImageUrlEvent>(_imageUrlEvent);
    on<RegisterLoadingEvent>(_handleLoadingEvent);


  }
  void _emailEvent(EmailEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _nameEvent(NameEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _passwordEvent(PasswordEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _rePasswordEvent(RePasswordEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(rePassword: event.rePassword));
  }
  void _imageUrlEvent(ImageUrlEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(imageUrl: event.imageUrl));
  }
  void _handleLoadingEvent(RegisterLoadingEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

}
