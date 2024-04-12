import 'dart:convert';

LoginReponse loginRespFromJson(String str) => LoginReponse.fromJson(json.decode(str));

String loginRespToJson(LoginReponse data) => json.encode(data.toJson());

class LoginReponse {
  LoginReponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  String accessToken;
  String tokenType;
  int expiresIn;

  factory LoginReponse.fromJson(Map<String, dynamic> json) => LoginReponse(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      expiresIn: json["expires_in"]);

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn
      };
}