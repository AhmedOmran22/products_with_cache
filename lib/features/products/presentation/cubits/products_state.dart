import '../../domain/entities/product_entity.dart';

sealed class ProductState {
  const ProductState();
}

final class ProductsLoading extends ProductState {
  const ProductsLoading();
}

final class ProductsSuccess extends ProductState {
  final List<ProductEntity> products;

  // Pagination flags — all live in state, not in the cubit.
  final bool isPaginationLoading;
  final bool isPaginationFinished;
  final bool isPaginationError;

  // Error flags for the initial load.
  final bool isInitialError;
  final String? errMessage;

  const ProductsSuccess({
    required this.products,
    this.isPaginationLoading = false,
    this.isPaginationFinished = false,
    this.isPaginationError = false,
    this.isInitialError = false,
    this.errMessage,
  });

  // _unset is a sentinel so callers can explicitly pass null for errMessage
  // (to clear it) while omitting the parameter preserves the current value.
  static const Object _unset = Object();

  ProductsSuccess copyWith({
    List<ProductEntity>? products,
    bool? isPaginationLoading,
    bool? isPaginationFinished,
    bool? isPaginationError,
    bool? isInitialError,
    Object? errMessage = _unset,
  }) {
    return ProductsSuccess(
      products: products ?? this.products,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
      isPaginationFinished: isPaginationFinished ?? this.isPaginationFinished,
      isPaginationError: isPaginationError ?? this.isPaginationError,
      isInitialError: isInitialError ?? this.isInitialError,
      errMessage: identical(errMessage, _unset)
          ? this.errMessage
          : errMessage as String?,
    );
  }
}

final class ProductsFailure extends ProductState {
  final String errMessage;

  const ProductsFailure({required this.errMessage});
}
