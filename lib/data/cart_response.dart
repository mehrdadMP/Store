class CartResponse {
  final int? productId;
  final int? cartItemId;
  final int? count;
  final String? error;
  final String? message;

  CartResponse([
    this.productId,
    this.cartItemId,
    this.count,
    this.error,
    this.message,
  ]);
  CartResponse.fromJason(Map<String, dynamic> jason,
      {this.error, this.message = 'محصول مورد نظر با موفقیت به سبد شما اضافه شد.'})
      : productId = jason['product_id'],
        cartItemId = jason['id'],
        count = jason['count'];

  CartResponse.getErrorfromJason(Map<String, dynamic> jason,
      {this.productId, this.cartItemId, this.count})
      : error = jason['error'],
        message = jason['message'];
}
