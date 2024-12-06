import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_match/feature/profil/domain/repository/profil_repository.dart';
import 'package:plant_match/feature/profil/presentation/cubit/profil_state.dart';

class ProfilCubit extends Cubit<ProfilState> {
  final ProfilRepository profilRepository;

  ProfilCubit({required this.profilRepository}) : super(ProfilInitial());

  Future<void> getProfilUser(String uid) async {
    try {
      final profilUser = await profilRepository.getProfilUser(uid);

      if (profilUser != null) {
        emit(ProfilLoaded(profilUser));
      } else {
        emit(ProfilError('Profil introuvable'));
      }
    } catch (e) {
      emit(ProfilError(e.toString()));
    }
  }

  Future<void> updateProfilUser({
    required String uid,
    required String? newBio,
    required String? newProfilImg,
    required String? newUserName,
    required String? newLocalisation,
    required String? newBirthdayDate,
  }) async {
    emit(ProfilLoading());
    try {
      final currentUser = await profilRepository.getProfilUser(uid);

      if (currentUser == null) {
        emit(ProfilError('Profil introuvable'));
        return;
      }

      final updatedProfilUser = currentUser.copyWith(
        newBio: newBio ?? currentUser.bio,
        newProfilImg: newProfilImg ?? currentUser.profilImg,
        newUserName: newUserName ?? currentUser.userName,
        newLocalisation: newLocalisation ?? currentUser.localisation,
        newBirthdayDate: newBirthdayDate ?? currentUser.birthdayDate,
      );

      await profilRepository.updateProfilUser(updatedProfilUser);

      await getProfilUser(uid);
    } catch (e) {
      emit(ProfilError(e.toString()));
    }
  }
}
