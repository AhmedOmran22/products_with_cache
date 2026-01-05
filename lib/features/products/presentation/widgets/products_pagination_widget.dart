import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/products_cubit.dart';
import '../cubits/products_state.dart';

class ProductsPaginationWidget extends StatelessWidget {
  const ProductsPaginationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
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
        } else if (state.isPaginationError) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Text(
                  state.errMessage ?? "Check your internet connection",
                  style: const TextStyle(color: Colors.red),
                ),
                TextButton(
                  onPressed: () {
                    cubit.pagination();
                  },
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
