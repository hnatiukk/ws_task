import 'package:dio/dio.dart';
import 'package:ws_task/models/api_response.dart';
import 'package:ws_task/utils/constants.dart';

class LevelApi {
  Future<ApiResponse> fetchLevels() async {
    Dio dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

    try {
      final response = await dio.get('/flutter/api');
      return ApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      return ApiResponse(error: true, message: 'Сталась помилка: $e');
    } finally {
      dio.close();
    }
  }
}
