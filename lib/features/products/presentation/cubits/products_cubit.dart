import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/pagination_helper.dart';
import '../../data/repos/products_repo.dart';
import 'products_state.dart';

class ProductCubit extends Cubit<ProductState> implements PaginationHelper {
  final ProductsRepo productsRepo;

  ProductCubit(this.productsRepo) : super(const ProductState());

  Future<void> getProducts() async {
    emit(state.copyWith(productsState: ProductsState.loading));

    final result = await productsRepo.getProducts();
    result.fold(
      (failure) => emit(
        state.copyWith(
          errMessage: failure.errMessage,
          productsState: ProductsState.failure,
        ),
      ),
      (products) => emit(
        state.copyWith(
          products: products,
          productsState: ProductsState.success,
        ),
      ),
    );
  }

  @override
  Future<void> pagination() async {}

  @override
  bool isPaginationFinished = false;

  @override
  bool isPaginationStarted = false;

  @override
  int limit = 10;

  @override
  int skip = 0;
}
