import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_recruitment_task/design_system/design_system.dart';
import 'package:flutter_recruitment_task/main.dart';
import 'package:flutter_recruitment_task/presentation/pages/home_page/home_cubit.dart';
import 'package:flutter_recruitment_task/presentation/pages/home_page/home_page.dart';
import 'package:flutter_recruitment_task/presentation/widgets/big_text.dart';
import 'package:flutter_recruitment_task/repositories/products_repository.dart';

class ItemSelectPage extends HookWidget {
  const ItemSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productIdTextController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const BigText('Select item'),
      ),
      body: Padding(
        padding: mainPadding,
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: productIdTextController,
                  decoration: const InputDecoration(labelText: 'Product ID'),
                ),
              ),
              SizedBox(width: mainPadding.right),
              FilledButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) {
                        return HomeCubit(getIt<ProductsRepository>());
                      },
                      child: HomePage(productId: productIdTextController.text),
                    ),
                  ),
                ),
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
