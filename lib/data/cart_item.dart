import 'package:store/data/product.dart';

class CartItemEntity {
  final ProductEntity productEntity;
  final int id;
  final int count;

  CartItemEntity(this.productEntity, this.id, this.count);
  CartItemEntity.fromJason(Map<String, dynamic> jason)
      : productEntity = jason['product'],
        id = jason['cart_item_id'],
        count = jason['count'];
}
