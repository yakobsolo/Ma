part of 'product_bloc_bloc.dart';

abstract class ProductBlocState {}

final class ProductBlocInitial extends ProductBlocState {}

final class ProductIsLoading extends ProductBlocState {}

final class ProductIsLoaded extends ProductBlocState {
  final List<CategoryMenu> demoCategoryMenus;

  ProductIsLoaded({required this.demoCategoryMenus});

  List<Object?> get props => [demoCategoryMenus];
}
