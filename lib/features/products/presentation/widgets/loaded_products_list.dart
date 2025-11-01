import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../cubits/products_cubit.dart';
import 'product_item.dart';

class LoadedProductsList extends StatelessWidget {
  const LoadedProductsList({
    super.key,
    required this.scrollController,
    required this.products,
  });

  final ScrollController scrollController;
  final List<ProductModel> products;

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
          final cubit = context.read<ProductCubit>();
          if (cubit.isPaginationFinished) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  "No more products 👌",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        }
      },
    );
  }
}
