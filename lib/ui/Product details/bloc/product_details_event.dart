part of 'product_details_bloc.dart';

sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class CartAddButtonClicked extends ProductDetailsEvent {
  final int productId;

  const CartAddButtonClicked(this.productId);
}
