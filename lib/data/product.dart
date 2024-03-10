class ProductSort {
  static const latest = 0;
  static const popular = 1;
  static const priceHighToLow = 2;
  static const priceLowToHigh = 3;
}

class ProductEntity {
  final int id;
  final String title;
  final String imageUrl;
  final int price;
  final int discount;
  final int previousPrice;
  ProductEntity.fromJason(Map<String, dynamic> jason)
      : id = jason['id'],
        title = jason['title'],
        imageUrl = jason['image'],
        price = jason['price'],
        previousPrice = jason['previous_price'] ?? jason['price'],
        discount = jason['discount'];
}
