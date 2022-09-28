import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../common/errors/app_error.dart';
import '../../../common/models/demoModel/demo_model.dart';


abstract class _HomeDataSource {
  Future<Either<AppError, List<DemoModel>>> exampleRequestBase(String postLink);
}

class HomeDataSource implements _HomeDataSource {
  HomeDataSource(this._dio);

  final Dio _dio;

  @override
  Future<Either<AppError, List<DemoModel>>> exampleRequestBase(String postLink) async {
    try {
      final response = await _dio.post(postLink);
      // /services/maps/assets/php/index.php?urlGetS3=8692902349/2022_08_1333/1661246642_optimized.json

      if (response.statusCode == 200) {
        final data =
            (json.decode(response.data) as Map<String, dynamic>).values;
        return right(
            List.from(data.map((data) => DemoModel.fromJson(data))));
      } else {
        return left(const AppError.serverError(message: 'Unknow Error'));
      }
    } on DioError catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

}
