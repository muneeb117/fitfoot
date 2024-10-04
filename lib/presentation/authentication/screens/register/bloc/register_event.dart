
import 'dart:io';

abstract class RegisterEvent{
  const RegisterEvent();
}
class EmailEvent extends RegisterEvent{
  final String email;
  EmailEvent(this.email);
}
class NameEvent extends RegisterEvent{
  final String name;
  NameEvent(this.name);

}
class PasswordEvent extends RegisterEvent{
  final String password;
  PasswordEvent(this.password);
}
class RePasswordEvent extends RegisterEvent{
  final String rePassword;
  RePasswordEvent(this.rePassword);
}
class ImageUrlEvent extends RegisterEvent {
  final File? imageUrl;
  ImageUrlEvent(this.imageUrl);
}
class RegisterLoadingEvent extends RegisterEvent {
  final bool isLoading;

  RegisterLoadingEvent(this.isLoading);
}