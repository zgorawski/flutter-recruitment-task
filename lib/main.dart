library;

import 'package:flutter/material.dart';
import 'package:flutter_recruitment_task/app.dart';
import 'package:flutter_recruitment_task/repositories/products_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<ProductsRepository>(MockedProductsRepository());

  runApp(const App());
}
