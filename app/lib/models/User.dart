class User {
  final String fullname;
  final String email;

  User({required this.fullname, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullname: json['fullname'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    'fullname': fullname,
    'email': email,
  };
}