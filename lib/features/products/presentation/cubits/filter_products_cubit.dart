import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/use_case/sort_products_use_case.dart';
import 'filter_products_state.dart';

class FilterProductsCubit extends Cubit<FilterProductsState> {
  final SortProductsUseCase sortProductsUseCase;

  FilterProductsCubit({
    required this.sortProductsUseCase,
    required List<ProductEntity> initialProducts,
  }) : super(
         FilterProductsState(
           products: sortProductsUseCase(initialProducts),
           status: FilterProductsStatus.success,
         ),
       );
}
