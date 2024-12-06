import 'package:plant_match/feature/auth/domain/entities/user_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserAuth user;
  Authenticated(this.user);
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class VerificationEmailSent extends AuthState {}

class VerificationPending extends AuthState {}

class EmailVerified extends AuthState {}

class EmailNotVerified extends AuthState {}
