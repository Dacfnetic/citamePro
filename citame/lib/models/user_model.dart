class Usuario {
  final String googleId;
  final String userName;
  final String userEmail;
  final String avatar;

  Usuario(
      {required this.googleId,
      required this.userName,
      required this.userEmail,
      required this.avatar});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        googleId: json['googleId'],
        userName: json['userName'],
        userEmail: json['emailUser'],
        avatar: json['avatar']);
  }
}
