import '../../domain/entities/product_entity.dart';

enum FilterProductsStatus { initial, loading, success, failure }

class FilterProductsState {
  final List<ProductEntity>? products;
  final String? errMessage;
  final FilterProductsStatus status;

  const FilterProductsState({
    this.products,
    this.errMessage,
    this.status = FilterProductsStatus.initial,
  });

  FilterProductsState copyWith({
    List<ProductEntity>? products,
    String? errMessage,
    FilterProductsStatus? status,
  }) {
    return FilterProductsState(
      products: products ?? this.products,
      errMessage: errMessage ?? this.errMessage,
      status: status ?? this.status,
    );
  }
}
