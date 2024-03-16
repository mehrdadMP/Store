import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/data/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Size screenSize;
  
  final ProductEntity product;

  const ProductDetailsScreen(
      {super.key, required this.screenSize, required this. product});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: screenSize.width * 0.8,
          backgroundColor: Colors.blue,
          flexibleSpace: CachedNetworkImage(imageUrl: product.imageUrl,fit: BoxFit.cover,),
        )
      ],
    );
  }
}
