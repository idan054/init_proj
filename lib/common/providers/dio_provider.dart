import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';

final dioProvider = Dio(
    BaseOptions(
      baseUrl:
          'http://services1-env.eba-wbrmgstr.us-east-2.elasticbeanstalk.com',
      receiveTimeout: 60000,
      connectTimeout: 60000,
      responseType: ResponseType.json,
      headers: <String, dynamic>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  )..interceptors.addAll([
      HttpFormatter(),
      LogInterceptor(),
    ]);
