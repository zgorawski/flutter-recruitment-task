import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recruitment_task/models/product_filters.dart';

final class FiltersState {
  const FiltersState({this.priceRangeFilter, this.bestOnlyFilter});

  final PriceRangeFilter? priceRangeFilter;
  final BestOfferFilter? bestOnlyFilter;

  List<ProductFilter> get allFilters => [
        if (priceRangeFilter != null) priceRangeFilter!,
        if (bestOnlyFilter != null) bestOnlyFilter!,
      ];

  FiltersState copyWith({PriceRangeFilter? Function()? priceRangeFilter, BestOfferFilter? Function()? bestOnlyFilter}) {
    return FiltersState(
      priceRangeFilter: priceRangeFilter != null ? priceRangeFilter() : this.priceRangeFilter,
      bestOnlyFilter: bestOnlyFilter != null ? bestOnlyFilter() : this.bestOnlyFilter,
    );
  }
}

class FiltersCubit extends Cubit<FiltersState> {
  FiltersCubit() : super(const FiltersState());

  void setPriceRange(PriceRange priceRange) {
    emit(state.copyWith(priceRangeFilter: () => PriceRangeFilter(priceRange: priceRange)));
  }

  void clearPriceRange() {
    emit(state.copyWith(priceRangeFilter: () => null));
  }

  void setShowBestOnly(bool showBestOnly) {
    final newFilter = showBestOnly  ? BestOfferFilter() : null;
    emit(state.copyWith(bestOnlyFilter: () => newFilter));
  }
}
