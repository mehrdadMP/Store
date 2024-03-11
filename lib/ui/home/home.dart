import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/repo/banner_repository.dart';
import 'package:store/data/repo/product_repository.dart';
import 'package:store/gen/assets.gen.dart';
import 'package:store/ui/home/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                        Container();
                    }
                    return Container();
                  },
                );
              } else if (state is HomeLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.appException.message),
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
