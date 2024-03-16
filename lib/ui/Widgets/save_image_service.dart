import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class SaveImageService extends StatelessWidget {
  final String imageUrl;
  const SaveImageService({
    super.key, required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: imageUrl,fit: BoxFit.fill,);
  }
}
