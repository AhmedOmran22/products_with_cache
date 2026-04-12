import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_products_use_case.dart';
import 'products_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final int pageSize;

  ProductCubit({
    required this.getProductsUseCase,
    this.pageSize = 10,
  }) : super(const ProductsLoading());

  // ── Helpers ──────────────────────────────────────────────────────────────

  /// Returns the current product list if the state carries one; null otherwise.
  ProductsSuccess? get _successState =>
      state is ProductsSuccess ? state as ProductsSuccess : null;

  // ── Public API ───────────────────────────────────────────────────────────

  /// Initial (or refresh) load.
  ///
  /// Consumes the Stream from the use case, which may emit up to two events:
  ///   • A cached snapshot first (instant display, stale-while-revalidate)
  ///   • Fresh remote data (or a failure) when the network call resolves
  Future<void> getProducts() async {
    emit(const ProductsLoading());

    await for (final result in getProductsUseCase(skip: 0, limit: pageSize)) {
      if (isClosed) return;

      result.fold(
        (failure) {
          final current = _successState;
          if (current != null) {
            // Already showing cached data — add an error banner, keep the list.
            emit(current.copyWith(
              isInitialError: true,
              errMessage: failure.errMessage,
            ));
          } else {
            // Nothing to fall back on — hard failure.
            emit(ProductsFailure(errMessage: failure.errMessage));
          }
        },
        (products) {
          emit(ProductsSuccess(
            products: products,
            isPaginationFinished: products.length < pageSize,
          ));
        },
      );
    }
  }

  /// Load the next page.
  ///
  /// All guards live here. The UI just calls this method on scroll — it does
  /// not need to check any flags itself.
  Future<void> pagination() async {
    final current = _successState;
    if (current == null) return;
    if (current.isPaginationLoading) return;
    if (current.isPaginationFinished) return;
    if (current.isPaginationError) return;

    // Derive skip from what we already have — no separate counter to maintain.
    final skip = current.products.length;

    emit(current.copyWith(isPaginationLoading: true));

    await for (final result in getProductsUseCase(skip: skip, limit: pageSize)) {
      if (isClosed) return;

      result.fold(
        (failure) {
          // Don't wipe existing products on a pagination error.
          emit(current.copyWith(
            isPaginationError: true,
            errMessage: failure.errMessage,
          ));
        },
        (newProducts) {
          final finished =
              newProducts.isEmpty || newProducts.length < pageSize;
          emit(current.copyWith(
            products: [...current.products, ...newProducts],
            isPaginationFinished: finished,
          ));
        },
      );
    }
  }

  /// Clears all error flags while preserving everything else in the state.
  void clearErrors() {
    final current = _successState;
    if (current == null) return;
    emit(current.copyWith(
      isPaginationError: false,
      isInitialError: false,
      errMessage: null,
    ));
  }
}
