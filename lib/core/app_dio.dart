import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:edoc_tabcom/core/utils/env.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'utils/local_storage.dart';
export 'package:dio/dio.dart';

final dioProvider = Provider((_) => AppDio.getInstance());
const _defaultConnectTimeout = 60000;

// ignore: prefer_mixin
class AppDio with DioMixin implements Dio {
  // AppDio._(this._reader, [BaseOptions? options]) {
  AppDio._([BaseOptions? options]) {
    options = BaseOptions(
      baseUrl: Environment.apiUrl,
      contentType: 'application/json',
      connectTimeout: const Duration(milliseconds: _defaultConnectTimeout),
      sendTimeout: const Duration(milliseconds: _defaultConnectTimeout),
      // receiveTimeout: _defaultConnectTimeout,
    );
    // if (UserPreferences.instance.getToken() != '') {
    //   options.headers = {'Authorization': 'Bearer ${UserPreferences.instance.getToken()}'};
    // }
    this.options = options;
    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (UserPreferences.instance.getToken() != '') {
            options.headers.addAll({'Authorization': 'Bearer ${UserPreferences.instance.getToken()}'});
          }

          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // final authNotifier = AppGlobal.instance.ref.read(authProvider);
            // showToast(ctx: AppGlobal.instance.context, mess: "Current user did not login to the application", color: Colors.red);
            // AppGlobal.instance.context.router.pushAndPopUntil(LoginRoute(), predicate: (_) => true);
            // await authNotifier.signOut();
            handler.next(error);
          } else {
            handler.next(error);
          }
        },
      ),
    );
    httpClientAdapter = IOHttpClientAdapter();
    (httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    // if (kDebugMode) {
    //   //Pretty Dio
    //   interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: false, error: true, maxWidth: 120, compact: true));
    // }
  }

  static Dio getInstance() => AppDio._();
}
