import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/cart_item.dart';
import 'package:store/data/repo/auth_repository.dart';
import 'package:store/data/repo/cart_repository.dart';
import 'package:store/ui/auth/auth.dart';
import 'package:store/ui/cart/bloc/cart_bloc.dart';
import 'package:text_scroll/text_scroll.dart';

class CartScreen extends StatelessWidget {
  final Size screenSize;
  const CartScreen({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("سبد خرید"),
      ),
      body: BlocProvider<CartBloc>(
        create: (context) {
          final bloc = CartBloc(cartRepository);
          bloc.add(CartStarted());
          return bloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else if (state is CartSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  List<CartItemEntity> items = state.cartResponse.cartItems;
                  return index == items.length - 1
                      ? SizedBox(
                          height: 100,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            decoration: BoxDecoration(
                                color: themeData.colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(10)),
                            width: screenSize.width,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: SizedBox(
                                        width: 125,
                                        height: 125,
                                        child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            height: 150,
                                            imageUrl: items[index].productEntity.imageUrl),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextScroll(items[index].productEntity.title.toString()),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextScroll(items[index].count.toString()),
                                    Column(
                                      children: [
                                        TextScroll(
                                            items[index].productEntity.previousPrice.toString()),
                                        TextScroll(items[index].productEntity.price.toString()),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                },
                itemCount: state.cartResponse.cartItems.length,
              );
            } else {
              throw Exception('State is not valid.');
            }
          },
        ),
      ),
    );
  }
}
