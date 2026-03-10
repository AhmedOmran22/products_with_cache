import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/products_repo.dart';
import 'products_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductsRepo productsRepo;

  ProductCubit(this.productsRepo) : super(const ProductState());

  int limit = 10;
  int skip = 0;

  bool isPaginationFinished = false;
  bool isPaginationStarted = false;

  Future<void> getProducts({int? skip, int? limit}) async {
    emit(state.copyWith(productsState: ProductsState.loading));

    final currentSkip = skip ?? 0;
    final currentLimit = limit ?? this.limit;

    if (currentSkip == 0) {
      this.skip = 0;
      isPaginationFinished = false;
      isPaginationStarted = false;
    }

    bool hasLocalData = false;

    if (currentSkip == 0) {
      final localProducts = await productsRepo.getLocalProducts();
      if (localProducts.isNotEmpty) {
        hasLocalData = true;
        emit(
          state.copyWith(
            products: localProducts,
            productsState: ProductsState.success,
          ),
        );
      }
    }

    final result = await productsRepo.getProducts(
      skip: currentSkip,
      limit: currentLimit,
    );

    result.fold(
      (failure) {
        if (hasLocalData) {
          emit(
            state.copyWith(
              errMessage: failure.errMessage,
              productsState: ProductsState.success,
              isInitialError: true,
              isPaginationError: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              errMessage: failure.errMessage,
              productsState: ProductsState.failure,
              isInitialError: true,
              isPaginationError: false,
            ),
          );
        }
      },
      (products) {
        if (products.isEmpty || products.length < currentLimit) {
          isPaginationFinished = true;
        }

        emit(
          state.copyWith(
            products: products,
            productsState: ProductsState.success,
            errMessage: null,
            isInitialError: false,
            isPaginationError: false,
          ),
        );
      },
    );
  }

  void clearErrors() {
    emit(state.resetErrorStates());
  }

  Future<void> pagination() async {
    if (isPaginationStarted || isPaginationFinished) return;

    isPaginationStarted = true;
    emit(
      state.copyWith(
        productsState: ProductsState.paginationLoading,
        isPaginationError: false,
        isInitialError: false,
      ),
    );

    final result = await productsRepo.getProducts(skip: skip + limit, limit: limit);

    result.fold(
      (failure) {
        isPaginationStarted = false;
        emit(
          state.copyWith(
            errMessage: failure.errMessage,
            productsState: ProductsState.success,
            isPaginationError: true,
            isInitialError: false,
          ),
        );
      },
      (newProducts) {
        isPaginationStarted = false;
        skip += limit;

        if (newProducts.isEmpty) {
          isPaginationFinished = true;
          emit(state.copyWith(productsState: ProductsState.success));
          return;
        }

        final allProducts = [...state.products!, ...newProducts];

        if (newProducts.length < limit) {
          isPaginationFinished = true;
        }

        emit(
          state.copyWith(
            products: allProducts,
            productsState: ProductsState.success,
            errMessage: null,
            isPaginationError: false,
            isInitialError: false,
          ),
        );
      },
    );
  }
}
