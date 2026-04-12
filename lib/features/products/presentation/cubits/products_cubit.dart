import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../../domain/usecases/get_local_products_use_case.dart';
import '../../domain/usecases/get_products_use_case.dart';
import 'products_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetLocalProductsUseCase getLocalProductsUseCase;

  ProductCubit({
    required this.getProductsUseCase,
    required this.getLocalProductsUseCase,
  }) : super(const ProductsLoading());

  int limit = 10;
  int skip = 0;

  bool isPaginationFinished = false;
  bool isPaginationStarted = false;

  List<ProductModel>? get _currentProducts => switch (state) {
    ProductsSuccess(:final products) => products,
    ProductsPaginationLoading(:final products) => products,
    _ => null,
  };

  Future<void> getProducts({int? skip, int? limit}) async {
    emit(const ProductsLoading());

    final currentSkip = skip ?? 0;
    final currentLimit = limit ?? this.limit;

    if (currentSkip == 0) {
      this.skip = 0;
      isPaginationFinished = false;
      isPaginationStarted = false;
    }

    bool hasLocalData = false;

    if (currentSkip == 0) {
      final localProducts = await getLocalProductsUseCase();
      if (localProducts.isNotEmpty) {
        hasLocalData = true;
        emit(ProductsSuccess(products: localProducts));
      }
    }

    final result = await getProductsUseCase(skip: currentSkip, limit: currentLimit);

    result.fold(
      (failure) {
        if (hasLocalData) {
          final current = _currentProducts ?? [];
          emit(
            ProductsSuccess(
              products: current,
              isInitialError: true,
              errMessage: failure.errMessage,
            ),
          );
        } else {
          emit(ProductsFailure(errMessage: failure.errMessage));
        }
      },
      (products) {
        if (products.isEmpty || products.length < currentLimit) {
          isPaginationFinished = true;
        }
        emit(ProductsSuccess(products: products));
      },
    );
  }

  void clearErrors() {
    if (state case ProductsSuccess(:final products)) {
      emit(ProductsSuccess(products: products));
    }
  }

  Future<void> pagination() async {
    if (isPaginationStarted || isPaginationFinished) return;

    final currentProducts = _currentProducts;
    if (currentProducts == null) return;

    isPaginationStarted = true;
    emit(ProductsPaginationLoading(products: currentProducts));

    final result = await getProductsUseCase(skip: skip + limit, limit: limit);

    result.fold(
      (failure) {
        isPaginationStarted = false;
        emit(
          ProductsSuccess(
            products: currentProducts,
            isPaginationError: true,
            errMessage: failure.errMessage,
          ),
        );
      },
      (newProducts) {
        isPaginationStarted = false;
        skip += limit;

        if (newProducts.isEmpty) {
          isPaginationFinished = true;
          emit(ProductsSuccess(products: currentProducts));
          return;
        }

        final allProducts = [...currentProducts, ...newProducts];
        if (newProducts.length < limit) {
          isPaginationFinished = true;
        }

        emit(ProductsSuccess(products: allProducts));
      },
    );
  }
}
