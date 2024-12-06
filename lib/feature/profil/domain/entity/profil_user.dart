import 'package:plant_match/feature/auth/domain/entities/user_auth.dart';

class ProfilUser extends UserAuth {
  final String bio;
  final String profilImg;
  final String userName;
  final String localisation;
  final String birthdayDate;

  ProfilUser({
    required super.uid,
    required super.email,
    required super.name,
    required this.bio,
    required this.profilImg,
    required this.userName,
    required this.localisation,
    required this.birthdayDate,
  });

  ProfilUser copyWith({
    String? newBio,
    String? newProfilImg,
    String? newUserName,
    String? newLocalisation,
    String? newBirthdayDate,
  }) {
    return ProfilUser(
      uid: uid,
      email: email,
      name: name,
      bio: newBio ?? bio,
      profilImg: newProfilImg ?? profilImg,
      userName: newUserName ?? userName,
      localisation: newLocalisation ?? localisation,
      birthdayDate: newBirthdayDate ?? birthdayDate,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'profilImg': profilImg,
      'userName': userName,
      'localisation': localisation,
      'birthdayDate': birthdayDate,
    };
  }

  factory ProfilUser.fromJson(Map<String, dynamic> json) {
    return ProfilUser(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      bio: json['bio'] ?? '',
      profilImg: json['profilImg'] ?? '',
      userName: json['userName'] ?? '',
      localisation: json['localisation'] ?? '',
      birthdayDate: json['birthdayDate'] ?? '',
    );
  }
}
