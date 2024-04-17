import 'package:dio/dio.dart';
import 'package:store/common/exceptions.dart';

mixin httpResponseValidator {
  void validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
