/**
 * Author: GeHaoRan
 * Date: 2019/12/3 8:33
 * Doc: dio 单例模式,设定dio基本配置
 */

import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';

BaseOptions baseOptions = BaseOptions(
  /// 请求基地址,可以包含子路径，如: "https://www.google.com/api/"
  baseUrl: 'http://120.55.125.154:8080/',

  /// 连接服务器超时时间，单位是毫秒
  connectTimeout: 5000,

  /// 接收数据的最长时限
  receiveTimeout: 3000,
);

Dio dio = Dio(baseOptions);

class CustomInterceptors extends Interceptor {
  CustomInterceptors();

  /// 在请求被发送之前做一些事情
  @override
  Future onRequest(RequestOptions options) {
    return super.onRequest(options);
  }

  /// 在返回响应数据之前做一些预处理
  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }

  /// 当请求失败时做一些预处理
  @override
  Future onError(DioError err) {
    //print(err);
    return super.onError(err);
  }
}

class DioHttp {
  void close({bool force = false}) {
    dio.close();
  }

  Future get(String path,
      {Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      onReceiveProgress}) async {
    try {
      Response response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 404) {
        return null;
      }
      return response.data;
    } on DioError catch (e) {
      return handleError(e);
    }
  }

  Future<Response<T>> getUri<T>(Uri uri,
      {Options options, CancelToken cancelToken, onReceiveProgress}) {
    return null;
  }

  Future post(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    onSendProgress,
    onReceiveProgress,
  }) async {
    try {
      Response response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 404) {
        return null;
      }
      return response.data;
    } on DioError catch (e) {
      return handleError(e);
    }
  }

  Future<Response<T>> postUri<T>(Uri uri,
      {data,
      Options options,
      CancelToken cancelToken,
      onSendProgress,
      onReceiveProgress}) {
    return null;
  }

  Future<Response<T>> put<T>(String path,
      {data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      onSendProgress,
      onReceiveProgress}) {
    return null;
  }

  Future<Response<T>> putUri<T>(Uri uri,
      {data,
      Options options,
      CancelToken cancelToken,
      onSendProgress,
      onReceiveProgress}) {
    return null;
  }

  Future<Response<T>> head<T>(String path,
      {data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken}) {
    return null;
  }

  Future<Response<T>> headUri<T>(Uri uri,
      {data, Options options, CancelToken cancelToken}) {
    return null;
  }

  Future<Response<T>> delete<T>(String path,
      {data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken}) {
    return null;
  }

  Future<Response<T>> deleteUri<T>(Uri uri,
      {data, Options options, CancelToken cancelToken}) {
    return null;
  }

  Future<Response<T>> patch<T>(String path,
      {data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      onSendProgress,
      onReceiveProgress}) {
    return null;
  }

  Future<Response<T>> patchUri<T>(Uri uri,
      {data,
      Options options,
      CancelToken cancelToken,
      onSendProgress,
      onReceiveProgress}) {
    return null;
  }

  Future<Response<T>> resolve<T>(response) {
    return dio.resolve(response);
  }

  Future<Response<T>> reject<T>(err) {
    return dio.reject(err);
  }

  lock() {
    dio.lock();
  }

  unlock() {
    dio.unlock();
  }

  clear() {
    dio.clear();
  }

  Future<Response> download(String urlPath, savePath,
      {onReceiveProgress,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options options}) {
    return null;
  }

  Future<Response> downloadUri(Uri uri, savePath,
      {onReceiveProgress,
      CancelToken cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options options}) {
    return null;
  }

  Future<Response<T>> request<T>(String path,
      {data,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      onSendProgress,
      onReceiveProgress}) {
    return null;
  }

  Future<Response<T>> requestUri<T>(Uri uri,
      {data,
      CancelToken cancelToken,
      Options options,
      onSendProgress,
      onReceiveProgress}) {
    return null;
  }

  handleError(DioError e) {
    if (e is! Response) {
      log('-- Dio 请求：服务端返回错误');

      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        log('-- 错误内容:${e.response.data}');
        log('-- 错误类型：连接超时【${e.response.statusCode}】');
      }
      if (e.type == DioErrorType.SEND_TIMEOUT) {
        log('-- 错误内容:${e.response.data}');
        log('-- 错误类型：请求超时【${e.response.statusCode}】');
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        log('-- 错误内容:${e.response.data}');
        log('-- 错误类型：响应超时【${e.response.statusCode}】');
      }
      if (e.type == DioErrorType.RESPONSE) {
        log('-- 错误类型：出现异常【${e.response.statusCode}】');
        return e.response.data;
      }
      if (e.type == DioErrorType.CANCEL) {
        log('-- 错误内容:${e.response.data}');
        log('-- 错误类型：请求取消【${e.response.statusCode}】');
      }
      return null;
    } else {
      log('-- Dio 请求：客户端返回错误');
      log('-- 错误内容:${e.request.data}');
      return null;
    }
  }
}
