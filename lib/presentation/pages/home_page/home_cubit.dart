import 'package:bloc/bloc.dart';
import 'package:flutter_recruitment_task/models/get_products_page.dart';
import 'package:flutter_recruitment_task/models/product_filters.dart';
import 'package:flutter_recruitment_task/models/products_page.dart';
import 'package:flutter_recruitment_task/repositories/products_repository.dart';

sealed class HomeState {
  const HomeState();
}

class Loading extends HomeState {
  const Loading();
}

class Loaded extends HomeState {
  const Loaded({required this.products, required this.isMoreDataAvailable});

  final List<Product> products;
  final bool isMoreDataAvailable;
}

class Error extends HomeState {
  const Error({required this.error});

  final dynamic error;
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._productsRepository) : super(const Loading());

  final ProductsRepository _productsRepository;
  final List<ProductsPage> _pages = [];
  List<ProductFilter> _filters = [];
  var _param = GetProductsPage(pageNumber: 1);

  Future<void> getNextPage() async {
    try {
      final totalPages = _pages.lastOrNull?.totalPages;
      if (totalPages != null && _param.pageNumber > totalPages) return;
      final newPage = await _productsRepository.getProductsPage(_param);
      _param = _param.increasePageNumber();
      _pages.add(newPage);
      emit(Loaded(products: _computeFilteredProducts(), isMoreDataAvailable: _isMoreDataAvailable()));
    } catch (e) {
      emit(Error(error: e));
    }
  }

  void applyFilters({required List<ProductFilter> filters}) {
    _filters = filters;
    emit(Loaded(products: _computeFilteredProducts(), isMoreDataAvailable: _isMoreDataAvailable()));
  }

  List<Product> _computeFilteredProducts() {
    return _pages
        .expand((page) => page.products)
        .where((product) => _filters.every((filter) => filter.isSatisfiedBy(product: product)))
        .toList();
  }

  bool _isMoreDataAvailable() {
    final totalPages = _pages.lastOrNull?.totalPages;
    return totalPages != null && _param.pageNumber <= totalPages;
  }
}
