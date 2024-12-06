import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_match/feature/auth/domain/entities/user_auth.dart';
import 'package:plant_match/feature/auth/domain/repository/auth_repository.dart';

class FirebaseAuthRepo implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<UserAuth?> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser != null) {
      return UserAuth(
        email: firebaseUser.email,
        uid: firebaseUser.uid,
        name: '',
      );
    } else {
      return null;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserAuth?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      UserAuth userAuth = UserAuth(
        email: email,
        uid: userCredential.user!.uid,
        name: '',
      );

      return userAuth;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Aucun compte trouvé pour cet email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Mot de passe incorrect.');
      } else if (e.code == 'invalid-email') {
        throw Exception('Email invalide.');
      } else if (e.code == 'user-disabled') {
        throw Exception('Ce compte a été désactivé.');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Les informations de connexion sont incorrectes.');
      } else {
        throw Exception(
            'Une erreur inattendue est survenue. Veuillez réessayer.');
      }
    } catch (e) {
      throw Exception('Une erreur inconnue est survenue. Veuillez réessayer.');
    }
  }

  @override
  Future<UserAuth> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserAuth userAuth = UserAuth(
        email: email,
        uid: userCredential.user!.uid,
        name: name,
      );

      await _firebaseFirestore.collection('users').doc(userAuth.uid).set({
        'email': userAuth.email,
        'name': userAuth.name,
      });

      return userAuth;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<UserAuth?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception("Connexion avec Google annulée.");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        UserAuth userAuth = UserAuth(
          email: firebaseUser.email,
          uid: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
        );

        await _firebaseFirestore.collection('users').doc(userAuth.uid).set({
          'email': userAuth.email,
          'name': userAuth.name,
        });
        return userAuth;
      } else {
        throw Exception("Échec de l'authentification avec Google.");
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      throw Exception(errorMessage);
    }
  }

  // Implémentation de la méthode de connexion avec Facebook
  @override
  Future<UserAuth?> signInWithFacebook() async {
    try {
      // Se connecter avec Facebook
      final nonce = DateTime.now().toIso8601String();
      final LoginResult result =
          await FacebookAuth.instance.login(permissions: [
        "public_profile",
        "email",
      ], loginTracking: LoginTracking.enabled, nonce: nonce);

      if (result.status == LoginStatus.success) {
        // Obtenir le jeton d'accès
        final userData = await FacebookAuth.instance.getUserData();
        final AccessToken accessToken = result.accessToken!;

        // Utiliser le jeton d'accès pour s'authentifier avec Firebase
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);
        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        await AppTrackingTransparency.requestTrackingAuthorization();

        final User? firebaseUser = userCredential.user;

        await FirebaseAuth.instance.signInWithCredential(credential);

        // Créer et renvoyer un objet UserAuth
        return UserAuth(
          email: userData['email'],
          uid: userData['id'],
          name: userData['name'],
        );
/*        if (firebaseUser != null) {
          return UserAuth(
            email: firebaseUser.email,
            uid: firebaseUser.uid,
            name: firebaseUser.displayName ?? '',
          );
        } else {
          throw Exception('Échec de l\'authentification avec Facebook.');
        }*/
      } else {
        throw Exception('Connexion avec Facebook annulée.');
      }
    } catch (e) {
      throw Exception('Échec de la connexion avec Facebook.');
    }
  }

  @override
/*  Future<void> sendVerificationEmail() async {
    final user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    } else if (user == null) {
      throw Exception("Aucun utilisateur connecté.");
    } else {
      throw Exception("L'utilisateur a déjà vérifié son e-mail.");
    }
  }*/

  Future<bool> sendVerificationEmail() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception("Aucun utilisateur connecté.");
    }

    await user.reload(); // Recharge les informations de l'utilisateur
    if (user.emailVerified) {
      return true; // L'e-mail est déjà vérifié
    } else {
      await user.sendEmailVerification(); // Envoie l'e-mail de vérification
      return false; // E-mail de vérification envoyé
    }
  }

  @override
  Future<void> reloadCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.reload(); // Recharge les informations utilisateur
    } else {
      throw Exception("Aucun utilisateur connecté.");
    }
  }

  @override
  Future<bool> checkEmailVerified() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.reload();
      return user.emailVerified;
    } else {
      throw Exception("Aucun utilisateur connecté.");
    }
  }
}
