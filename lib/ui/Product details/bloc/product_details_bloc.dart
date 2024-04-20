import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:store/common/exceptions.dart';
import 'package:store/data/cart_response.dart';
import 'package:store/data/repo/cart_repository.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ICartRepository cartRepository;
  ProductDetailsBloc(this.cartRepository) : super(ProductDetailsInitial()) {
    on<ProductDetailsEvent>((event, emit) async {
      //String addToCartError = '';
      if (event is CartAddButtonClicked) {
        emit(ProductAddToCartButtonLoading());
        //CartResponse response = CartResponse();
        /* try { */
          CartResponse response = await cartRepository
              .addProductToCart(event.productId)
              .onError<DioException>((error, stackTrace) {
            CartResponse addToCartError = CartResponse.getErrorfromJason(error.response!.data);
            //debugPrint(error.response!.data['message']);
            //addToCartError = error.response!.data['message'];
            return addToCartError;
          });
          emit(ProductAddToCartButtonSuccess(response));
        /* } catch (e) {
          emit(ProductAddToCartButtonError(AppException(message: response.message!)));
        } */
      }
    });
  }
}
