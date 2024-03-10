import 'package:dio/dio.dart';
import 'package:store/data/banner.dart';
import 'package:store/data/common/response_validator.dart';

abstract class IbannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource
    with httpResponseValidator
    implements IbannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);
  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpClient.get('banner/slider');
    validateResponse(response);
    final List<BannerEntity> banners = <BannerEntity>[];
    for (var element in (response.data as List)) {
      banners.add(BannerEntity.fromJason(element));
    }
    return banners;
  }
}
