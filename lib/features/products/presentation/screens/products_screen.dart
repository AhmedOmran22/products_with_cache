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
    context.read<ProductCubit>().getProducts();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = context.read<ProductCubit>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !cubit.isPaginationStarted &&
        !cubit.isPaginationFinished) {
      cubit.pagination();
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
      body: BlocListener<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state.errMessage != null) {
            final cubit = context.read<ProductCubit>();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage!),
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: () {
                    if (state.isPaginationError) {
                      cubit.pagination();
                    } else if (state.isInitialError) {
                      cubit.getProducts();
                    }
                  },
                ),
              ),
            );
            // Clear errors after showing snackbar so it doesn't show again on rebuild
            cubit.clearErrors();
          }
        },
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state.productsState == ProductsState.loading) {
              return const LoadingProductsList();
            }
            if ((state.productsState == ProductsState.success ||
                    state.productsState == ProductsState.paginationLoading) &&
                state.products != null) {
              return LoadedProductsList(
                scrollController: _scrollController,
                products: state.products!,
              );
            }
            if (state.productsState == ProductsState.failure) {
              return Center(child: Text(state.errMessage ?? 'Unknown error'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
