class CartResponse {
  final int productId;
  final int cartItemId;
  final int count;

  CartResponse(this.productId, this.cartItemId, this.count);
  CartResponse.fronJason(Map<String, dynamic> jason)
      : productId = jason['product_id'],
        cartItemId = jason['id'],
        count = jason['count'];
}
