class LoginBody {
  String? email;
  String? password;
  String? device_name;

  LoginBody({
    this.email,
    this.password,
    this.device_name
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'device_name': device_name,
    };
  }
}