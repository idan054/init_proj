import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:http/http.dart' as http;

// source: https://stackoverflow.com/questions/57977167/device-country-in-flutter
Future<Map<String, dynamic>> getLocation() async {
  var response = await http.post(Uri.parse('http://ip-api.com/json'));
  if (response.statusCode == 200) {
    var respBody = jsonDecode(response.body);
    // print('resp ${response.body}');
    print('country ${respBody["country"]}');

    // Set on provider.
    // Location location = Location.fromJson(respBody);
    // kUserModel(context).updateUser(RilUser(location: location));

    return respBody;
  } else {
    return {'status': 'No data'};
  }
}

final dioProvider = Dio(
  BaseOptions(
    baseUrl: 'http://services1-env.eba-wbrmgstr.us-east-2.elasticbeanstalk.com',
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

void getUrlParams() {
  String? url = Uri.base.toString(); //get complete url
  print('url: $url');

  final uriParams = Uri.parse(url.replaceAll('/#/', '/')).queryParameters;
  var companyIdParam =
      uriParams['CompanyID'] ?? uriParams['companyID'] ?? '3417818890';
  var employeeIdParam =
      uriParams['EmployeeId'] ?? uriParams['employeeId'] ?? '557';
  var dateParam = uriParams['date'] ?? uriParams['Date'] ?? '1661240852';

  print('companyIdParam: $companyIdParam');
  print('employeeIdParam: $employeeIdParam');
  print('dateParam: $dateParam');
}
