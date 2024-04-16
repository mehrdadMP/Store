import 'package:store/data/cart_item.dart';
import 'package:store/data/cart_response.dart';

abstract class ICartRepository {
  Future<CartResponse> addProductToCart(int productId);
  Future<CartResponse> changeItemCount(int cartItemId, int count);
  Future<void> removeItemFromCart(int cartItemId);
  Future<int> cartItemsCount();
  Future<List<CartItemEntity>> getAll();
}

class CartRepository implements ICartRepository{
  @override
  Future<CartResponse> addProductToCart(int productId) {
    // TODO: implement addProductToCart
    throw UnimplementedError();
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