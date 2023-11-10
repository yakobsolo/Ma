part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class GetCarts  extends CartEvent {}