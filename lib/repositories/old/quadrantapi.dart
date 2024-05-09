// import 'dart:convert';

// import 'package:quadrant_app/models/ErrorResponse.dart';
// import 'package:quadrant_app/models/LoginRespose.dart';
// import 'package:http/http.dart' as http;

// class QuadrantAPI {
//   static var client = http.Client();
//   static const _baseURL = "http://quadrant-api.test";

//   static Future<List> login({required String email, required String password}) async {
//     var response = await client.post(Uri.parse('$_baseURL/auth/login'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body:
//             jsonEncode(<String, String>{"email": email, "password": password}));

//     if (response.statusCode == 200) {
//       var json = response.body;
//       var loginRes = loginRespFromJson(json);
//       if (loginRes != null) {
//         return [loginRes.accessToken, ""];
//       } else {
//         return ["", "Unknown Error"];
//       }
//     } else {
//       var json = response.body;
//       var errorResp = errorRespFromJson(json);
//       if (errorResp == null) {
//         return ["", "Unknown Error"];
//       } else {
//         return ["", errorResp.error];
//       }
//     }
//   }
// }
