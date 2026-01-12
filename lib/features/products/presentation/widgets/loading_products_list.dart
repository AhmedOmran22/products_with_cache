import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/product_model.dart';
import 'product_item.dart';

class LoadingProductsList extends StatelessWidget {
  const LoadingProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Skeletonizer(
          enabled: true,
          child: ProductItem(product: ProductModel.fakeProduct.toEntity()),
        );
      },
    );
  }
}
