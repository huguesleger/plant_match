class UserAuth {
  final String uid;
  final String? email;
  final String name;

  UserAuth({
    required this.uid,
    required this.email,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
    );
  }
}
