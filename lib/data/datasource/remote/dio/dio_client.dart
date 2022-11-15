import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmiis/models/district_new_model.dart';
import 'package:lmiis/models/new_grade_model.dart';
import 'package:lmiis/models/new_muni_model.dart';
import 'package:lmiis/models/pradeshModel.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../utils/AppConstants.dart';
import 'logging_interceptor.dart';

class DioClient {
  final String baseUrl;
  final LoggingInterceptor? loggingInterceptor;

  Dio? dio;
  String? token;

  DioClient(this.baseUrl, Dio? dioC, {this.loggingInterceptor}) {
    dio = dioC ?? Dio();
    dio?.options.baseUrl = baseUrl;
    dio?.options.connectTimeout = 60 * 1000;
    dio?.options.receiveTimeout = 60 * 1000;
    dio?.httpClientAdapter = DefaultHttpClientAdapter();
    dio?.interceptors.add(loggingInterceptor!);
  }

  Future<Response?> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final box = GetStorage();
      token = box.read(AppConstants.TOKEN);
      dio?.options.headers = {'Authorization': 'Bearer $token'};
      var response = await dio?.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      print('===============${e.toString()}');
      throw e;
    }
  }

  Future<Response?> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final box = GetStorage();
      token = box.read(AppConstants.TOKEN);
      dio?.options.headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      dio?.options.followRedirects = true;
      dio?.options.validateStatus = (status) => true;

      var response = await dio?.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response?> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final box = GetStorage();
      token = box.read(AppConstants.TOKEN);
      dio?.options.headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };

      var response = await dio?.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response?> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final box = GetStorage();
      token = box.read(AppConstants.TOKEN);
      dio?.options.headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };
      var response = await dio?.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
}

class ApiClient {
  final dio = Dio();

  Future<List<NewPradeshModel>> getPradeshData() async {
    final result = await dio.get("http://139.59.21.174/api/pradesh");
    final responseData = result.data;
    return List.from(responseData['data'])
        .map((e) => NewPradeshModel.fromMap(e))
        .toList();
  }

  Future<List<DistrictNewModel>> getDistricts() async {
    final result = await dio.get("http://139.59.21.174/api/districts");
    final responseData = result.data;
    return List.from(responseData['data'])
        .map((e) => DistrictNewModel.fromMap(e))
        .toList();
  }

  Future<List<NewMuniModel>> getMunicipalities() async {
    final result = await dio.get("http://139.59.21.174/api/municipalities");
    final responseData = result.data;
    return List.from(responseData['data'])
        .map((e) => NewMuniModel.fromMap(e))
        .toList();
  }

  Future<List<NewGradeModel>> getGrades() async {
    final result = await dio.get("http://139.59.21.174/api/category");
    final responseData = result.data;
    return List.from(responseData['data'])
        .map((e) => NewGradeModel.fromMap(e))
        .toList();
  }
}
