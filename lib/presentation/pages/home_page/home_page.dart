import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_recruitment_task/design_system/design_system.dart';
import 'package:flutter_recruitment_task/models/products_page.dart';
import 'package:flutter_recruitment_task/presentation/pages/home_page/home_cubit.dart';
import 'package:flutter_recruitment_task/presentation/widgets/big_text.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomePage extends HookWidget {
  const HomePage({super.key, this.productId});

  final String? productId;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      if (productId case final productId?) {
        context.read<HomeCubit>().getNextPage();
      } else {
        context.read<HomeCubit>().getNextPage();
      }

      return null;
    }, [productId]);

    final autoScrollController = useMemoized(() => AutoScrollController());

    return Scaffold(
      appBar: AppBar(
        title: const BigText('Products'),
      ),
      body: Padding(
        padding: mainPadding,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return switch (state) {
              Error() => BigText('Error: ${state.error}'),
              Loading() => const BigText('Loading...'),
              Loaded() => _LoadedWidget(state: state, controller: autoScrollController),
            };
          },
        ),
      ),
    );
  }
}

class _LoadedWidget extends StatelessWidget {
  const _LoadedWidget({
    required this.state,
    required this.controller,
  });

  final Loaded state;
  final AutoScrollController controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _ProductsSliverList(state: state, controller: controller),
        const _GetNextPageButton(),
      ],
    );
  }
}

class _ProductsSliverList extends StatelessWidget {
  const _ProductsSliverList({required this.state, required this.controller});

  final Loaded state;
  final AutoScrollController controller;

  @override
  Widget build(BuildContext context) {
    final products = state.pages.map((page) => page.products).expand((product) => product).toList();

    return SliverList.separated(
      itemCount: products.length,
      itemBuilder: (context, index) => AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: _ProductCard(products[index]),
      ),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(product.name),
          _Tags(product: product),
        ],
      ),
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: product.tags.map(_TagWidget.new).toList(),
    );
  }
}

class _TagWidget extends StatelessWidget {
  _TagWidget(this.tag) : color = Colors.primaries[tag.hashCode % Colors.primaries.length];

  final Tag tag;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Chip(
        color: MaterialStateProperty.all(color),
        label: Text(tag.label),
      ),
    );
  }
}

class _GetNextPageButton extends StatelessWidget {
  const _GetNextPageButton();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: TextButton(
        onPressed: context.read<HomeCubit>().getNextPage,
        child: const BigText('Get next page'),
      ),
    );
  }
}
