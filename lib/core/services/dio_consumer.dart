import 'package:dio/dio.dart';

import '../constants/end_points.dart';
import '../errors/exception.dart';
import '../errors/failure.dart';
import 'api_service.dart';

class DioConsumer implements ApiService {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
  }

  @override
  Future get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw CustomException(
        message: ServerFailure.fromDioExcepiton(e).errMessage,
      );
    }
  }

  @override
  Future post(
    String endPoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(
        endPoint,
        data: isFormData
            ? FormData.fromMap(data as Map<String, dynamic>)
            : data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw CustomException(
        message: ServerFailure.fromDioExcepiton(e).errMessage,
      );
    }
  }

  @override
  Future patch(
    String endPoint, {
    Object? data,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(
        endPoint,
        data: isFormData
            ? FormData.fromMap(data as Map<String, dynamic>)
            : data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw CustomException(
        message: ServerFailure.fromDioExcepiton(e).errMessage,
      );
    }
  }

  @override
  Future delete(
    String endPoint, {
    Object? data,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(
        endPoint,
        data: isFormData
            ? FormData.fromMap(data as Map<String, dynamic>)
            : data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw CustomException(
        message: ServerFailure.fromDioExcepiton(e).errMessage,
      );
    }
  }

  @override
  Future put(
    String endPoint, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.put(
        endPoint,
        data: isFormData ? FormData.fromMap(data) : data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw CustomException(
        message: ServerFailure.fromDioExcepiton(e).errMessage,
      );
    }
  }
}
