import 'package:cache_and_theme_task_mentorship/core/widgets/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/products_cubit.dart';
import '../cubits/products_state.dart';
import '../widgets/loaded_products_list.dart';
import '../widgets/loading_products_list.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductCubit>().pagination();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Theme and Cache App Demo",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [const ThemeSwitcher(), const SizedBox(width: 20)],
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: BlocListener<ProductCubit, ProductState>(
                listener: (context, state) {
                  if (state case ProductsSuccess(
                    isInitialError: true,
                    :final errMessage,
                  )) {
                    final cubit = context.read<ProductCubit>();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errMessage ?? 'An error occurred'),
                        action: SnackBarAction(
                          label: 'Retry',
                          onPressed: () => cubit.getProducts(),
                        ),
                      ),
                    );
                    cubit.clearErrors();
                  }
                },
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    return switch (state) {
                      ProductsLoading() => const LoadingProductsList(),
                      ProductsSuccess(:final products) =>
                        products.isEmpty
                            ? const Center(child: Text('No products found'))
                            : LoadedProductsList(
                                scrollController: _scrollController,
                                products: products,
                              ),
                      ProductsFailure(:final errMessage) => Center(
                        child: Text(errMessage),
                      ),
                    };
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
