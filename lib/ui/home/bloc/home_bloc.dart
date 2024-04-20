import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store/common/exceptions.dart';
import 'package:store/data/banner.dart';
import 'package:store/data/product.dart';
import 'package:store/data/repo/banner_repository.dart';
import 'package:store/data/repo/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository;
  final IProductRepository productRepository;
  HomeBloc({required this.bannerRepository, required this.productRepository})
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      try {
        emit(HomeLoading());
        if (event is HomeStarted) {
          final banners = await bannerRepository.getAll();
          final products = await productRepository.getAll(ProductSort.latest);
          final popularProducts =
              await productRepository.getAll(ProductSort.popular);
          emit(HomeSuccess(
              banners: banners,
              products: products,
              popularProducts: popularProducts));
        }
        if (event is HomeRefresh) {
          final banners = await bannerRepository.getAll();
          final products = await productRepository.getAll(ProductSort.latest);
          final popularProducts =
              await productRepository.getAll(ProductSort.popular);
          emit(HomeSuccess(
              banners: banners,
              products: products,
              popularProducts: popularProducts));
        }
      } catch (e) {
        emit(
          HomeError(
            exception: e is AppException ? e : AppException(message: e.toString()),
          ),
        );
      }
    });
  }
}
