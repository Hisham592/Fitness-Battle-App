abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailur extends AuthState {
  final String message;

  AuthFailur({required this.message});
}
