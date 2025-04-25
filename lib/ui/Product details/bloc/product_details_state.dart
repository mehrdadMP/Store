part of 'product_details_bloc.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductAddToCartButtonLoading extends ProductDetailsState {}

final class ProductAddToCartButtonError extends ProductDetailsState {
  final AppException exception;

  ProductAddToCartButtonError(this.exception);

  @override
  // TODO: implement props
  List<Object> get props => [exception];
}

final class ProductAddToCartButtonSuccess extends ProductDetailsState {
  final AddToCartResponse response;
  ProductAddToCartButtonSuccess(this.response);
}
