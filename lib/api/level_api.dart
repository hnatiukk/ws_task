import 'package:dio/dio.dart';
import 'package:ws_task/models/api_response.dart';
import 'package:ws_task/models/level_result.dart';
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

  Future<ApiResponse> sendResults(List<LevelResult> levelResults) async {
    Dio dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

    try {
      final response = await dio.post('/flutter/api',
          data: levelResults
              .map(
                (result) => result.toJson(),
              )
              .toList());

      return ApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      return ApiResponse(error: true, message: 'Сталась помилка: $e');
    } finally {
      dio.close();
    }
  }
}
