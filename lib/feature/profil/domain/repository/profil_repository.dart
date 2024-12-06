import 'package:plant_match/feature/profil/domain/entity/profil_user.dart';

abstract class ProfilRepository {
  Future<ProfilUser?> getProfilUser(String uid);
  Future<void> updateProfilUser(ProfilUser updateProfilUser);
}
