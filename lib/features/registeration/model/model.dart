class RegisterRequestBody {
  String email;
  String password;
  String name;
  String surename;

  RegisterRequestBody({
    required this.email,
    required this.password,
    required this.name,
    required this.surename,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'phone_number': surename,
    };
  }

  factory RegisterRequestBody.fromJson(Map<String, dynamic> json) {
    return RegisterRequestBody(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      name: json['name'] ?? '',
      surename: json['surename'] ?? '',
    );
  }
}