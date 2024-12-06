import 'package:plant_match/feature/auth/domain/entities/user_auth.dart';

abstract class AuthRepository {
  Future<UserAuth?> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<UserAuth?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<void> logOut();

  Future<UserAuth?> getCurrentUser();

  Future<UserAuth?> signInWithGoogle();

  Future<UserAuth?> signInWithFacebook();

  //Future<void> sendVerificationEmail();
  Future<bool> sendVerificationEmail();

  Future<void> reloadCurrentUser();

  Future<bool> checkEmailVerified();
}
