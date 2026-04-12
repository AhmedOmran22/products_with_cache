import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';
import 'product_item.dart';
import 'products_pagination_widget.dart';

class LoadedProductsList extends StatelessWidget {
  const LoadedProductsList({
    super.key,
    required this.scrollController,
    required this.products,
  });

  final ScrollController scrollController;
  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: products.length + 1,
      itemBuilder: (context, index) {
        if (index < products.length) {
          final product = products[index];
          return ProductItem(product: product);
        } else {
          return const ProductsPaginationWidget();
        }
      },
    );
  }
}
