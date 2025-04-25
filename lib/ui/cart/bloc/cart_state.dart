part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final CartItemsResponse cartResponse;

  CartSuccess(this.cartResponse);
  @override
  // TODO: implement props
  List<Object> get props => [cartResponse];
}

final class CartError extends CartState {
  final AppException exception;

  const CartError(this.exception);
}
