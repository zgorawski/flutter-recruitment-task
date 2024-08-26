import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_recruitment_task/models/get_products_page.dart';
import 'package:flutter_recruitment_task/models/product_filters.dart';
import 'package:flutter_recruitment_task/presentation/pages/home_page/home_cubit.dart';
import 'package:flutter_recruitment_task/repositories/products_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'test_data.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

class FakeGetProductsPage extends Fake implements GetProductsPage {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeGetProductsPage());
  });
  group(HomeCubit, () {
    late HomeCubit defaultHomeCubit;
    late ProductsRepository productsRepository;

    setUp(() {
      productsRepository = MockProductsRepository();
      defaultHomeCubit = HomeCubit(productsRepository);
    });

    test('initial state is Loading', () {
      expect(defaultHomeCubit.state, const Loading());
    });

    blocTest(
      'emits Error when repository throws on getNextPage',
      build: () => defaultHomeCubit,
      setUp: () {
        when(() => productsRepository.getProductsPage(any())).thenThrow('test error');
      },
      act: (bloc) => bloc.getNextPage(),
      expect: () => [isA<Error>().having((it) => it.error, 'error', 'test error')],
    );

    blocTest(
      'emits Loaded when repository returns page',
      build: () => defaultHomeCubit,
      setUp: () {
        when(() => productsRepository.getProductsPage(any())).thenAnswer((_) async => aProductPage(totalPages: 1));
      },
      act: (bloc) => bloc.getNextPage(),
      expect: () => [
        isA<Loaded>()
            .having((it) => it.products.length, 'expected amount of products', 1)
            .having((it) => it.products.first.id, 'expected product id', aProduct.id)
            .having((it) => it.isMoreDataAvailable, 'isMoreDataAvailable', false),
      ],
      verify: (_) {
        verify(() => productsRepository.getProductsPage(const GetProductsPage(pageNumber: 1))).called(1);
      },
    );

    blocTest(
      'if there is no more data available, does not emit anything, and does not call repository',
      build: () => defaultHomeCubit,
      setUp: () {
        when(() => productsRepository.getProductsPage(any())).thenAnswer(
          (_) async => aProductPage(totalPages: 1),
        );
      },
      act: (bloc) async {
        await bloc.getNextPage();
        await bloc.getNextPage();
      },
      skip: 1,
      expect: () => [],
      verify: (_) {
        verify(() => productsRepository.getProductsPage(any())).called(1);
      },
    );

    blocTest(
      'correctly indicated more data available',
      build: () => defaultHomeCubit,
      setUp: () {
        when(() => productsRepository.getProductsPage(any())).thenAnswer((_) async => aProductPage(totalPages: 2));
      },
      act: (bloc) => bloc.getNextPage(),
      expect: () => [
        isA<Loaded>().having((it) => it.isMoreDataAvailable, 'isMoreDataAvailable', true),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'uses filters when emiting loaded products',
      build: () => defaultHomeCubit,
      setUp: () {
        when(() => productsRepository.getProductsPage(any())).thenAnswer(
          (_) async => aProductPage(pageSize: 2, products: [aProduct, productWithPrice100]),
        );
      },
      act: (bloc) async {
        bloc.applyFilters(filters: [PriceRangeFilter(priceRange: (from: 100, to: 100))]);
        await bloc.getNextPage();
      },
      expect: () => [
        isA<Loaded>()
            .having((it) => it.products.length, 'expected amount of products', 1)
            .having((it) => it.products.first.id, 'expected product id', productWithPrice100.id)
      ],
    );
  });
}
