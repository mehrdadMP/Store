import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store/common/utils.dart';
import 'package:store/data/product.dart';
import 'package:store/theme.dart';
import 'package:store/ui/Product%20details/comment/comment_list.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Size screenSize;

  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.screenSize, required this.product});
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    foregroundColor: LightThemeColor.primaryTextColor,
                    expandedHeight: screenSize.width * 0.8,
                    flexibleSpace: CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.heart,
                          color: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: FittedBox(
                                      child: Text(
                                product.title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ))),
                              SizedBox(
                                width: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    product.previousPrice.withPriceLabel,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(product.price.withPriceLabel)
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '''یک کفش کتونی شیک و بادوام که هم برای '''
                            ''' دویدن و هم راه رفتن مناسب می‌باشد. این کفش از '''
                            '''وارد شدن فشار و آسیب به پای شما جلوگیری می‌کند.''',
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.7),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'نظرات کاربران',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                TextButton(
                                    style: textButtonStyle,
                                    onPressed: () {},
                                    child: Text('ثبت نظر')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CommentList(productId: product.id),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 160,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(left: 25,right: 25,bottom: 100,
            child: FloatingActionButton.extended(
                onPressed: () {},
                label: Text(
                  'افزودن به سبد خرید',
                  style: themeData.textTheme.labelLarge!
                      .copyWith(color: themeData.colorScheme.onPrimary),
                )),
          ),
        ],
      ),
    );
  }
}
