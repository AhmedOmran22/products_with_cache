import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/filter_products_cubit.dart';
import '../cubits/filter_products_state.dart';
import '../widgets/product_item.dart';

class FilterProductsScreen extends StatefulWidget {
  const FilterProductsScreen({super.key});

  @override
  State<FilterProductsScreen> createState() => _FilterProductsScreenState();
}

class _FilterProductsScreenState extends State<FilterProductsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Sorted Products (Low to High Price)")),
      body: BlocBuilder<FilterProductsCubit, FilterProductsState>(
        builder: (context, state) {
          if (state.status == FilterProductsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == FilterProductsStatus.failure) {
            return Center(child: Text(state.errMessage ?? 'Unknown error'));
          }
          if (state.status == FilterProductsStatus.success &&
              state.products != null) {
            if (state.products!.isEmpty) {
              return const Center(child: Text("No products found"));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              itemCount: state.products!.length,
              itemBuilder: (context, index) {
                return ProductItem(product: state.products![index]);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
