abstract class LoginEvents {
  const LoginEvents();
}

class EmailEvents extends LoginEvents {
  final String email;
  EmailEvents(this.email);
}

class PasswordEvents extends LoginEvents {
  final String password;
  PasswordEvents(this.password);
}

class LoginResetEvent extends LoginEvents {
}
class LoginLoadingEvent extends LoginEvents {
  final bool isLoading;

  LoginLoadingEvent(this.isLoading);
}
class LoginCredentialsClearedEvent extends LoginEvents {}
