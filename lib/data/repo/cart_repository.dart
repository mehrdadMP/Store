import 'package:store/data/cart_item.dart';
import 'package:store/data/add_to_cart_response.dart';
import 'package:store/data/cart_items_response.dart';
import 'package:store/data/common/http_client.dart';
import 'package:store/data/source/cart_data_source.dart';

final cartRepository = CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartRepository {
  Future<AddToCartResponse> addProductToCart(int productId);
  Future<AddToCartResponse> changeItemCount(int cartItemId, int count);
  Future<void> removeItemFromCart(int cartItemId);
  Future<int> cartItemsCount();
  Future<CartItemsResponse> getAll();
}

class CartRepository implements ICartRepository {
  final ICartDataSource cartDataSource;

  CartRepository(this.cartDataSource);
  @override
  Future<AddToCartResponse> addProductToCart(int productId) {
    return cartDataSource.addProductToCart(productId);
  }

  @override
  Future<int> cartItemsCount() {
    // TODO: implement cartItemsCount
    throw UnimplementedError();
  }

  @override
  Future<AddToCartResponse> changeItemCount(int cartItemId, int count) {
    // TODO: implement changeItemCount
    throw UnimplementedError();
  }

  @override
  Future<CartItemsResponse> getAll() => cartDataSource.getAll();

  @override
  Future<void> removeItemFromCart(int cartItemId) {
    // TODO: implement removeItemFromCart
    throw UnimplementedError();
  }
}
