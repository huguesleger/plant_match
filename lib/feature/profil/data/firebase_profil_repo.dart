import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_match/feature/profil/domain/entity/profil_user.dart';
import 'package:plant_match/feature/profil/domain/repository/profil_repository.dart';

class FirebaseProfilRepo implements ProfilRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<ProfilUser?> getProfilUser(String uid) async {
    try {
      final userDoc =
          await _firebaseFirestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data();

        if (userData != null) {
          return ProfilUser(
            uid: uid,
            email: userData['email'],
            name: userData['name'],
            bio: userData['bio'] ?? '',
            profilImg: userData['profilImg'].toString(),
            userName: userData['userName'] ?? '',
            localisation: userData['localisation'] ?? '',
            birthdayDate: userData['birthdayDate'] ?? '',
          );
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<void> updateProfilUser(ProfilUser updateProfilUser) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(updateProfilUser.uid)
          .update({
        'bio': updateProfilUser.bio,
        'profilImg': updateProfilUser.profilImg,
        'userName': updateProfilUser.userName,
        'localisation': updateProfilUser.localisation,
        'birthdayDate': updateProfilUser.birthdayDate,
      });
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du profil');
    }
  }
}
