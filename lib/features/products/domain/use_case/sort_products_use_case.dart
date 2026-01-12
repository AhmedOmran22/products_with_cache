import '../entities/product_entity.dart';

class SortProductsUseCase {
  List<ProductEntity> call(List<ProductEntity> products) {
    // Sort products by price from low to high
    final sortedList = List<ProductEntity>.from(products);
    sortedList.sort((a, b) => a.price.compareTo(b.price));
    return sortedList;
  }
}
