import 'package:dio/dio.dart';

class DioManager {
  static DioManager? _instance;

  static DioManager get instance {
    if (_instance != null) return _instance!;
    _instance = DioManager._init();
    return _instance!;
  }

  final String _baseUrl = 'https://api.thinesjaishankar.com';
  // final String _baseUrl = 'http://localhost:8800';
  late final Dio dio;

  DioManager._init() {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        followRedirects: true,
      ),
    );
  }
}