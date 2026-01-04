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

    final currentSkip = skip ?? this.skip;
    final currentLimit = limit ?? this.limit;
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
        if (!hasLocalData) {
          emit(
            state.copyWith(
              errMessage: failure.errMessage,
              productsState: ProductsState.failure,
            ),
          );
        }
      },
      (products) {
        if (products.isEmpty || products.length < currentLimit) {
          isPaginationFinished = true;
        }

        emit(
          state.copyWith(products: products, productsState: ProductsState.success),
        );
      },
    );
  }

  Future<void> pagination() async {
    if (isPaginationStarted || isPaginationFinished) return;

    isPaginationStarted = true;
    emit(state.copyWith(productsState: ProductsState.paginationLoading));

    skip += limit;

    final result = await productsRepo.getProducts(skip: skip, limit: limit);

    result.fold(
      (failure) {
        isPaginationStarted = false;
        emit(
          state.copyWith(
            errMessage: failure.errMessage,
            productsState: ProductsState.failure,
          ),
        );
      },
      (newProducts) {
        isPaginationStarted = false;

        if (newProducts.isEmpty) {
          isPaginationFinished = true;
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
          ),
        );
      },
    );
  }
}
