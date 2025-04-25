import 'package:store/data/cart_item.dart';

class CartItemsResponse {
  final List<CartItemEntity> cartItems;
  final int? payablePrice;
  final int? totalPrice;
  final int? shippingCost;

  CartItemsResponse(
    this.cartItems,
    this.payablePrice,
    this.totalPrice,
    this.shippingCost,
  );
  CartItemsResponse.fromJason(Map<String, dynamic> jason)
      : cartItems = addItemFromJasonToArray(jason['cart_items']),
        payablePrice = jason['payable_price'],
        totalPrice = jason['total_price'],
        shippingCost = jason['shipping_cost'];
}

List<CartItemEntity> addItemFromJasonToArray(items) {
  List<CartItemEntity> cartItem = <CartItemEntity>[];
  for (var element in items) {
      cartItem.add(CartItemEntity.fromJason(element));
    }
  return cartItem;
}
