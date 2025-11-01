import '../../data/models/product_model.dart';

enum ProductsState { loading, success, failure, paginationLoading }

class ProductState {
  final List<ProductModel>? products;
  final String? errMessage;
  final ProductsState productsState;

  const ProductState({
    this.products,
    this.errMessage,
    this.productsState = ProductsState.loading,
  });

  ProductState copyWith({
    List<ProductModel>? products,
    String? errMessage,
    ProductsState? productsState,
  }) {
    return ProductState(
      products: products ?? this.products,
      errMessage: errMessage ?? this.errMessage,
      productsState: productsState ?? this.productsState,
    );
  }
}
