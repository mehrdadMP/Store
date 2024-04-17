import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store/common/exceptions.dart';
import 'package:store/data/repo/cart_repository.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ICartRepository cartRepository;
  ProductDetailsBloc(this.cartRepository) : super(ProductDetailsInitial()) {
    on<ProductDetailsEvent>((event, emit) {
      if (event is CartAddButtonClicked) {
        emit(ProductAddToCartButtonLoading());
        try {
          cartRepository.addProductToCart(event.productId);
          emit(ProductAddToCartButtonSuccess());
        } catch (e) {
          emit(ProductAddToCartButtonError(AppException()));
        }
      }
    });
  }
}
