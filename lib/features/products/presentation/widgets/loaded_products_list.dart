import 'package:flutter/widgets.dart';

import '../../data/models/product_model.dart';
import 'product_item.dart';

class LoadedProductsList extends StatelessWidget {
  const LoadedProductsList({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItem(product: product);
            },
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
