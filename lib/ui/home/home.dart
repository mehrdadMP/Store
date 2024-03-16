import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/repo/banner_repository.dart';
import 'package:store/data/repo/product_repository.dart';
import 'package:store/gen/assets.gen.dart';
import 'package:store/ui/Widgets/slider.dart';
import 'package:store/ui/home/bloc/home_bloc.dart';
import 'package:store/ui/Widgets/horizontal_list_view.dart';

class HomeScreen extends StatelessWidget {
  final Size screenSize;
  final EdgeInsetsGeometry padding = const EdgeInsets.only(left: 20, right: 20);
  const HomeScreen({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) {
        final homeBloc = HomeBloc(
            bannerRepository: bannerRepository,
            productRepository: productRepository);
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (BuildContext context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Image.asset(
                          Assets.img.nike.path,
                          width: 75,
                          height: 75,
                        );
                      case 1:
                        Container();
                      case 2:
                        return BannerSlider(
                          screenSize: screenSize,
                          padding: padding,
                          borderRadius: BorderRadius.circular(20),
                          banners: state.banners,
                        );
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
                );
              } else if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.appException.message),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(HomeRefresh());
                          },
                          child: Text('تلاش مجدد'))
                    ],
                  ),
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
