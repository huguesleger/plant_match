import 'package:plant_match/feature/profil/domain/entity/profil_user.dart';

abstract class ProfilState {}

class ProfilInitial extends ProfilState {}

class ProfilLoading extends ProfilState {}

class ProfilLoaded extends ProfilState {
  final ProfilUser profilUser;
  ProfilLoaded(this.profilUser);
}

class ProfilError extends ProfilState {
  final String message;
  ProfilError(this.message);
}
