import 'package:dio/dio.dart';
import 'package:store/data/cart_item.dart';
import 'package:store/data/cart_response.dart';
import 'package:store/data/common/response_validator.dart';

abstract class ICartDataSource {
  Future<CartResponse> addProductToCart(int productId);
  Future<CartResponse> changeItemCount(int cartItemId, int count);
  Future<void> removeItemFromCart(int cartItemId);
  Future<int> cartItemsCount();
  Future<List<CartItemEntity>> getAll();
}

class CartRemoteDataSource implements ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSource(this.httpClient);
  @override
  Future<CartResponse> addProductToCart(int productId) async {
    final response = await httpClient.post('cart/add', data: {"product_id": productId});
    validateResponse(response);
    final cartResponse = CartResponse.fronJason(response.data);
    return cartResponse;
  }

  @override
  Future<int> cartItemsCount() {
    // TODO: implement cartItemsCount
    throw UnimplementedError();
  }

  @override
  Future<CartResponse> changeItemCount(int cartItemId, int count) {
    // TODO: implement changeItemCount
    throw UnimplementedError();
  }

  @override
  Future<List<CartItemEntity>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<void> removeItemFromCart(int cartItemId) {
    // TODO: implement removeItemFromCart
    throw UnimplementedError();
  }
}
