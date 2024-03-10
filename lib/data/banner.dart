class BannerEntity {
  final int id;
  final String imageUrl;
  BannerEntity.fromJason(Map<String, dynamic> jason)
      : id = jason['id'],
        imageUrl = jason['image'];
}
