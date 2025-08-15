part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.loginRequested(LoginRequestModel request) =
      LoginRequested;
  const factory AuthEvent.registerRequested(RegisterRequestModel request) =
      RegisterRequested;
  const factory AuthEvent.logoutRequested() = LogoutRequested;
  const factory AuthEvent.checkLoginStatus() = CheckLoginStatus;
  const factory AuthEvent.checkFirstRunApp() = CheckFirstRunApp;
}
