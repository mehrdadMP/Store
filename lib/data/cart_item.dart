import 'package:store/data/product.dart';

class CartItemEntity {
  final ProductEntity productEntity;
  final int id;
  final int count;

  CartItemEntity.fromJason(Map<String, dynamic> jason)
      : productEntity = ProductEntity.fromJason(jason['product']),
        id = jason['cart_item_id'],
        count = jason['count'];
}
