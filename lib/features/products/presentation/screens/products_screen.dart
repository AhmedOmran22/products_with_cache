import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/products_cubit.dart';
import '../cubits/products_state.dart';
import '../widgets/loading_products_list.dart';
import '../widgets/product_item.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state.productsState == ProductsState.loading) {
            return const LoadingProductsList();
          } else if (state.productsState == ProductsState.success) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.products!.length,
              itemBuilder: (context, index) {
                final product = state.products![index];
                return ProductItem(product: product);
              },
            );
          } else {
            return Text(state.errMessage!);
          }
        },
      ),
    );
  }
}
