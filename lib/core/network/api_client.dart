import 'package:dio/dio.dart';
import 'package:distributor_retailer_app/core/error/api_exception.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({String? baseUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl ?? "",
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            "Content-Type": "application/json",
          },
        ));

  Future<dynamic> get(
  String url, {
  Map<String, dynamic>? queryParameters,
  Map<String, dynamic>? headers,
  Map<String, dynamic>? data,
}) async {
  try {
    final response = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(headers: headers),
      data: data,
    );
    return response.data;
  } catch (error) {
    throw ApiException.fromDioError(error);
  }
}


 Future<dynamic> post(
  String url, {
  dynamic data,
  Map<String, dynamic>? headers,
}) async {
  try {
    print("📡 POST Request");
    print("➡️ URL: $url");
    if (headers != null) print("➡️ Headers: $headers");

    if (data is FormData) {
      print("➡️ Data (FormData):");
      data.fields.forEach((f) => print("   ${f.key} = ${f.value}"));
      data.files.forEach((f) => print("   FILE: ${f.key} -> ${f.value.filename}"));
    } else {
      print("➡️ Data: $data");
    }

    final response = await _dio.post(
      url,
      data: data,
      options: Options(headers: headers),
    );

    print("✅ Response [${response.statusCode}]: ${response.data}");

    return response.data;
  } catch (error) {
    print("❌ API Error: $error");
    throw ApiException.fromDioError(error);
  }
}

}
