import '../../data/models/product_model.dart';

enum ProductsState { loading, success, failure, paginationLoading }

class ProductState {
  final List<ProductModel>? products;
  final String? errMessage;
  final ProductsState productsState;
  final bool isPaginationError;
  final bool isInitialError;

  const ProductState({
    this.products,
    this.errMessage,
    this.productsState = ProductsState.loading,
    this.isPaginationError = false,
    this.isInitialError = false,
  });

  ProductState copyWith({
    List<ProductModel>? products,
    String? errMessage,
    ProductsState? productsState,
    bool? isPaginationError,
    bool? isInitialError,
  }) {
    return ProductState(
      products: products ?? this.products,
      errMessage: errMessage ?? this.errMessage,
      productsState: productsState ?? this.productsState,
      isPaginationError: isPaginationError ?? this.isPaginationError,
      isInitialError: isInitialError ?? this.isInitialError,
    );
  }

  ProductState resetErrorStates() {
    return ProductState(
      products: products,
      productsState: productsState,
      errMessage: null,
      isPaginationError: false,
      isInitialError: false,
    );
  }
}
