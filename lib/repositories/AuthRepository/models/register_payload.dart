class RegisterBody {
  String? name;
  String? email;
  String? password;
  String? device_name;

  RegisterBody({
    this.name,
    this.email,
    this.password,
    this.device_name
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'device_name': device_name,
    };
  }
}