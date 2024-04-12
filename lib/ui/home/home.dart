import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/common/utils.dart';
import 'package:store/data/repo/banner_repository.dart';
import 'package:store/data/repo/product_repository.dart';
import 'package:store/gen/assets.gen.dart';
import 'package:store/ui/Widgets/error_widget.dart';
import 'package:store/ui/Widgets/slider.dart';
import 'package:store/ui/home/bloc/home_bloc.dart';
import 'package:store/ui/Widgets/horizontal_list_view.dart';

class HomeScreen extends StatelessWidget {
  final Size screenSize;
  final EdgeInsetsGeometry padding = const EdgeInsets.only(left: 20, right: 20);
  const HomeScreen({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<HomeBloc>(
          create: (context) {
            final homeBloc =
                HomeBloc(bannerRepository: bannerRepository, productRepository: productRepository);
            homeBloc.add(HomeStarted());
            return homeBloc;
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (BuildContext context, state) {
              if (state is HomeSuccess) {
                return SizedBox(
                  height: screenSize.height,
                  child: Stack(
                    children: [
                      Container(
                        width: screenSize.width,
                        height: 215,
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Opacity(
                                  opacity: 1,
                                  child: Image.asset(
                                    Assets.img.nikeShoe2.path,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                ClipRect(
                                    child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                                        child: Image.asset(
                                          Assets.img.nikeShoe2.path,
                                          width: 50,
                                          height: 50,
                                        )))
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'فروشگاه کفش‌',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 126,
                        bottom: 5,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            BannerSlider(
                              screenSize: screenSize,
                              padding: padding,
                              borderRadius: BorderRadius.circular(20),
                              banners: state.banners,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                              child: Expanded(
                                child: ListView.builder(
                                  physics: scrollPhysics,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    switch (index) {
                                      case 0:
                                        return Container();
                                      case 1:
                                        Container();
                                      case 2:
                                        return Container();
                                      case 3:
                                        return HorizontalListView(
                                          screenSize: screenSize,
                                          padding: padding,
                                          title: 'جدیدترین',
                                          products: state.products,
                                        );
                                      case 4:
                                        return HorizontalListView(
                                          screenSize: screenSize,
                                          padding: padding,
                                          title: 'پربازدیدترین',
                                          products: state.popularProducts,
                                        );
                                    }
                                    return Container();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return AppErrorWidget(
                  exception: state.exception,
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                  },
                );
              } else {
                throw Exception('State not supported');
              }
            },
          ),
        ),
      ),
    );
  }
}
