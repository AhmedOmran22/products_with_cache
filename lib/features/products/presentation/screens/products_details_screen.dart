import 'package:flutter/material.dart';
import '../../domain/entities/product_entity.dart';
import '../widgets/product_image_carousel.dart';
import '../widgets/product_rating_chip.dart';
import '../widgets/product_price_card.dart';
import '../widgets/product_info_card.dart';
import '../widgets/product_availability_section.dart';
import '../widgets/product_warranty_section.dart';

class ProductsDetailsScreen extends StatelessWidget {
  const ProductsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final product = ModalRoute.of(context)!.settings.arguments as ProductEntity;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text(product.title), elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageCarousel(product: product),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      ProductRatingChip(rating: product.rating),
                      Chip(
                        label: Text(product.brand),
                        backgroundColor: isDark
                            ? Colors.blue.withOpacity(0.15)
                            : Colors.blue[50],
                        side: BorderSide(
                          color: isDark
                              ? Colors.blue.withOpacity(0.3)
                              : Colors.blue[200]!,
                        ),
                      ),
                      Chip(
                        label: Text(product.category),
                        backgroundColor: isDark
                            ? Colors.purple.withOpacity(0.15)
                            : Colors.purple[50],
                        side: BorderSide(
                          color: isDark
                              ? Colors.purple.withOpacity(0.3)
                              : Colors.purple[200]!,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  ProductPriceCard(product: product),
                  const SizedBox(height: 16),
                  ProductInfoCard(
                    title: 'Description',
                    icon: Icons.description,
                    child: Text(
                      product.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ProductInfoCard(
                    title: 'Availability',
                    icon: Icons.inventory_2,
                    child: ProductAvailabilitySection(product: product),
                  ),
                  const SizedBox(height: 12),
                  ProductInfoCard(
                    title: 'Warranty & Returns',
                    icon: Icons.verified_user,
                    child: ProductWarrantySection(product: product),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
