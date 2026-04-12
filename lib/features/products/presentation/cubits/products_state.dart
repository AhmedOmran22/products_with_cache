import '../../data/models/product_model.dart';

sealed class ProductState {
  const ProductState();
}

final class ProductsLoading extends ProductState {
  const ProductsLoading();
}

final class ProductsSuccess extends ProductState {
  final List<ProductModel> products;
  final bool isPaginationError;
  final bool isInitialError;
  final String? errMessage;

  const ProductsSuccess({
    required this.products,
    this.isPaginationError = false,
    this.isInitialError = false,
    this.errMessage,
  });
}

final class ProductsPaginationLoading extends ProductState {
  final List<ProductModel> products;

  const ProductsPaginationLoading({required this.products});
}

final class ProductsFailure extends ProductState {
  final String errMessage;

  const ProductsFailure({required this.errMessage});
}
