import 'package:dio/dio.dart';

class Services {
  var dio = Dio();

  Future<Response> postFunction(String url, dynamic body,
      {dynamic header}) async {
    try {
      var response =
          await dio.post(url, data: body, options: Options(headers: header));
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> getFunction(
    String url,
  ) async {
    try {
      var response = await dio.get(
        url,
      );
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }
}
