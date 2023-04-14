class UserModel {
  final String uuid;
  final String name;
  final String email;
  final String password;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.uuid,
  });

  //toJSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  //fromJSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uuid: json['uuid'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
}
