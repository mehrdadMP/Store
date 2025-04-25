import 'package:dio/dio.dart';
import 'package:store/common/exceptions.dart';
import 'package:store/data/common/response_validator.dart';
import 'package:store/data/product.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource
    with httpResponseValidator
    implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);
  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final response = await httpClient.get('product/list?sort=$sort');
    validateResponse(response);
 
    final List<ProductEntity> productsList = <ProductEntity>[];
    for (var element in (response.data as List)) {
      productsList.add(ProductEntity.fromJason(element));
    }
    return productsList;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final response = await httpClient.get('product/search?q=$searchTerm');
    validateResponse(response);

    final List<ProductEntity> productsList = <ProductEntity>[];
    for (var element in (response.data as List)) {
      productsList.add(ProductEntity.fromJason(element));
    }
    return productsList;
  }
}
