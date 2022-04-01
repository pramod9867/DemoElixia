import 'dart:io';

import 'package:demo_elixia/utils/constants/appcontants.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class ApiClient {
  Dio? dioClient;

  ApiClient.defaultClient({BaseOptions? baseOptions}) {
    if (baseOptions == null) {
      baseOptions = BaseOptions(
        baseUrl: 'http://api.weatherapi.com/v1',
        connectTimeout: 120000,
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Charset": "utf-8",
        },
        receiveTimeout: 120000,
      );
    }

    print(baseOptions);
    dioClient = Dio(baseOptions);

    // dioClient!.interceptors.add(LogInterceptor());

    (dioClient?.httpClientAdapter as DefaultHttpClientAdapter)
        .onHttpClientCreate = (HttpClient? client) {
      client!.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
      return client;
    };
  }

  ApiClient.googleClient({BaseOptions? baseOptions}) {
    if (baseOptions == null) {
      baseOptions = BaseOptions(
        baseUrl: 'https://maps.googleapis.com/maps/api/place/autocomplete/',
        connectTimeout: 120000,
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Charset": "utf-8",
        },
        receiveTimeout: 120000,
      );
    }

    print(baseOptions);
    dioClient = Dio(baseOptions);

    // dioClient!.interceptors.add(LogInterceptor());

    (dioClient?.httpClientAdapter as DefaultHttpClientAdapter)
        .onHttpClientCreate = (HttpClient? client) {
      client!.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
      return client;
    };
  }
}
