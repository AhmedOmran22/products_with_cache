import '../../data/models/product_model.dart';

enum ProductsState { loading, success, failure, paginationLoading }

class ProductState {
  final List<ProductModel>? products;
  final List<ProductModel>? filteredProducts;
  final String? errMessage;
  final ProductsState productsState;
  final bool isPaginationError;
  final bool isInitialError;
  final String searchQuery;

  const ProductState({
    this.products,
    this.filteredProducts,
    this.errMessage,
    this.productsState = ProductsState.loading,
    this.isPaginationError = false,
    this.isInitialError = false,
    this.searchQuery = '',
  });

  ProductState copyWith({
    List<ProductModel>? products,
    List<ProductModel>? filteredProducts,
    String? errMessage,
    ProductsState? productsState,
    bool? isPaginationError,
    bool? isInitialError,
    String? searchQuery,
  }) {
    return ProductState(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      errMessage: errMessage ?? this.errMessage,
      productsState: productsState ?? this.productsState,
      isPaginationError: isPaginationError ?? this.isPaginationError,
      isInitialError: isInitialError ?? this.isInitialError,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  ProductState resetErrorStates() {
    return ProductState(
      products: products,
      filteredProducts: filteredProducts,
      productsState: productsState,
      errMessage: null,
      isPaginationError: false,
      isInitialError: false,
      searchQuery: searchQuery,
    );
  }
}
