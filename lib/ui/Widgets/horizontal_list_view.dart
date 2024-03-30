import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:store/common/utils.dart';
import 'package:store/data/product.dart';
import 'package:store/ui/Product%20details/product_details.dart';
import 'package:text_scroll/text_scroll.dart';

class HorizontalListView extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final List<ProductEntity>? products;
  
  final Size screenSize;

  const HorizontalListView({
    super.key,
    required this.padding,
    required this.title,
    this.onTap,
    this.products, required this. screenSize,
  });

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: padding.add(EdgeInsets.only(top: 20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              TextButton(
                  style: textButtonStyle,
                  onPressed: onTap!=null ?onTap:(){},
                  child: Text('مشاهده‌ی همه')),
            ],
          ),
        ),
        SizedBox(
          height: products != null ? 242 : 175,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: products != null
                ? scrollPhysics
                : NeverScrollableScrollPhysics(),
            itemCount: products == null ? 5 : products!.length,
            itemBuilder: (context, index) {
              final product = products != null ? products![index] : null;
              return Padding(
                padding: index == 0
                    ? EdgeInsets.only(left: 10, right: 20)
                    : ((products == null && index == 4) ||
                            (products != null && index == products!.length - 1))
                        ? EdgeInsets.only(left: 20)
                        : EdgeInsets.only(left: 10),
                child: products == null
                    ? Container(
                        width: 175,
                        height: 175,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                      )
                    : InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(screenSize:screenSize,product:product),
                        )),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: 175,
                                  height: 175,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: product!.imageUrl,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width: 30,
                                    height: 30,
                                    child: Icon(
                                      CupertinoIcons.heart,
                                      color: Colors.pink,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 175,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 7, right: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextScroll(
                                      product.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      textDirection: TextDirection.rtl,
                                      velocity: Velocity(
                                          pixelsPerSecond: Offset(15, 0)),
                                      pauseBetween: Duration(seconds: 5),
                                      intervalSpaces: 30,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      product.previousPrice.withPriceLabel,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough),
                                    ),
                                    Text(product.price.withPriceLabel),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            },
          ),
        )
      ],
    );
  }
}
