part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final AppException exception;

  const HomeError({required this.exception});
  @override
  List<Object> get props => [exception];
}

class HomeSuccess extends HomeState {
  final List<BannerEntity> banners;
  final List<ProductEntity> products;
  final List<ProductEntity> popularProducts;

  const HomeSuccess(
      {required this.banners,
      required this.products,
      required this.popularProducts});
}
