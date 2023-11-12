part of 'product_bloc_bloc.dart';

@immutable
sealed class ProductBlocEvent {}

class GetProducts extends ProductBlocEvent {}
