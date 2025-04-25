import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store/common/exceptions.dart';
import 'package:store/data/cart_items_response.dart';
import 'package:store/data/repo/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStarted) {
        try {
          emit(CartLoading());
          final result = await cartRepository.getAll();
          emit(CartSuccess(result));
        } catch (e) {
          emit(CartError(AppException(message: e.toString())));
        }
      }
    });
  }
}
