// import 'package:get/get.dart';
// import 'package:quadrant_app/services/QuadrantAPI.dart';
// import 'package:quadrant_app/services/secure_storage.dart';

// class AuthController extends GetxController with SecureStorage {
//   final isLogged = false.obs;

//   Future<String> login({required String email, required String password}) async {
//     var loginProcess = false.obs;
//     var error = "";
//     try {
//       loginProcess(true);
//       List loginResp = await QuadrantAPI.login(email: email, password: password);
//       if (loginResp[0] != "") {
//         //success
//         isLogged.value = true;
//         await saveToken(loginResp[0]);
//       } else {
//         //error
//         isLogged.value = false;
//         error = loginResp[1];
//       }
//     } finally {
//       loginProcess(false);
//     }
//     return error;
//   }

//   Future<void> debugTokenLogin() async {
//     await saveToken("reyabajajfh");
//     isLogged.value = true;
//   }

//   void logout() {
//     isLogged.value = false;
//     deleteToken();
//   }

//   void checkLoginStatus() async {
//     String? token = await getToken();
//     if (token != null) {
//       isLogged.value = true;
//     }
//   }
  
// }