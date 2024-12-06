import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_match/feature/auth/domain/entities/user_auth.dart';
import 'package:plant_match/feature/auth/domain/repository/auth_repository.dart';
import 'package:plant_match/feature/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  UserAuth? _currentUser;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  void checkCurrentUser() async {
    final UserAuth? user = await authRepository.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      final UserAuth? user = await authRepository.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(AuthError(errorMessage));
      emit(Unauthenticated());
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      emit(AuthLoading());
      final UserAuth? user = await authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(AuthError(errorMessage));
      emit(Unauthenticated());
    }
  }

  UserAuth? get currentUser => _currentUser;

  Future<void> logOut() async {
    authRepository.logOut();
    emit(Unauthenticated());
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());
      final UserAuth? user = await authRepository.signInWithGoogle();
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(AuthError(errorMessage));
      emit(Unauthenticated());
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      emit(AuthLoading());
      final UserAuth? user = await authRepository.signInWithFacebook();
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(AuthError(errorMessage));
      emit(Unauthenticated());
    }
  }

/*
  Future<void> sendVerificationEmail() async {
    try {
      final isVerified = await authRepository.checkEmailVerified();
      if (isVerified) {
        emit(EmailVerified());
      } else {
        await authRepository.sendVerificationEmail();
        emit(VerificationEmailSent());
      }
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(AuthError(errorMessage));
    }
  }
*/

  Future<void> sendVerificationEmail() async {
    try {
      emit(AuthLoading());
      final isVerified = await authRepository.sendVerificationEmail();
      if (isVerified) {
        emit(EmailVerified());
      } else {
        emit(VerificationEmailSent());
      }
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(AuthError(errorMessage));
    }
  }

  Future<void> refreshUserAndCheckVerification() async {
    final UserAuth user = _currentUser!;
    try {
      await authRepository
          .reloadCurrentUser(); // Recharge les données de l'utilisateur
      final isEmailVerified = await authRepository
          .checkEmailVerified(); // Vérifie si l'e-mail est vérifié
      if (isEmailVerified) {
        emit(Authenticated(user)); // Met à jour l'état comme authentifié
      } else {
        emit(
            VerificationPending()); // État pour indiquer que la vérification est toujours nécessaire
      }
    } catch (e) {
      emit(AuthError(e.toString())); // Gestion des erreurs
    }
  }

  Future<void> checkEmailVerified() async {
    try {
      emit(AuthLoading());
      final isVerified = await authRepository.checkEmailVerified();
      if (isVerified) {
        emit(EmailVerified());
      } else {
        emit(EmailNotVerified());
      }
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(AuthError(errorMessage));
    }
  }
}
