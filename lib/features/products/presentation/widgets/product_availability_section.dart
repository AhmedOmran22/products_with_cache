import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductAvailabilitySection extends StatelessWidget {
  final ProductModel product;

  const ProductAvailabilitySection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              product.stock > 0 ? Icons.check_circle : Icons.cancel,
              color: product.stock > 0 ? Colors.green : Colors.red,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              product.availabilityStatus,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: product.stock > 0 ? Colors.green[700] : Colors.red[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Stock: ${product.stock} units',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }
}
