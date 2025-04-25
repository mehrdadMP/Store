import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:store/data/cart_item.dart';
import 'package:store/data/add_to_cart_response.dart';
import 'package:store/data/cart_items_response.dart';
import 'package:store/data/common/response_validator.dart';

abstract class ICartDataSource {
  Future<AddToCartResponse> addProductToCart(int productId);
  Future<AddToCartResponse> changeItemCount(int cartItemId, int count);
  Future<void> removeItemFromCart(int cartItemId);
  Future<int> cartItemsCount();
  Future<CartItemsResponse> getAll();
}

class CartRemoteDataSource with httpResponseValidator implements ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSource(this.httpClient);
  @override
  Future<AddToCartResponse> addProductToCart(int productId) async {
    final response = await httpClient.post('cart/add', data: {"product_id": productId});
    validateResponse(response);
    return AddToCartResponse.fromJason(response.data);
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
  Future<CartItemsResponse> getAll() async {
    final response = await httpClient.get('cart/list');
    validateResponse(response);

    final cartInfo = CartItemsResponse.fromJason(response.data);
    /*    final List<dynamic> cartItems = <dynamic>[];
    for (var element in CartInfo.cartItems) {
      cartItems.add(CartItemEntity.fromJason(element));
    }
    final CartItemsResponse cart ;
    cart.insert(0, cartItems);
    cart.insert(1, CartInfo.payablePrice);
    cart.insert(2, CartInfo.totalPrice);
    cart.insert(3, CartInfo.shippingCost);

    return cart; */
    return cartInfo;
  }

  @override
  Future<void> removeItemFromCart(int cartItemId) {
    // TODO: implement removeItemFromCart
    throw UnimplementedError();
  }
}
