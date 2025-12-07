import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductWarrantySection extends StatelessWidget {
  final ProductModel product;

  const ProductWarrantySection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.shield, size: 18, color: Colors.blue),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                product.warrantyInformation,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.assignment_return, size: 18, color: Colors.green),
            const SizedBox(width: 8),
            Expanded(
              child: Text(product.returnPolicy, style: theme.textTheme.bodyMedium),
            ),
          ],
        ),
      ],
    );
  }
}
