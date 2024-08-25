import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recruitment_task/models/product_filters.dart';

final class FiltersState {
  const FiltersState({this.priceRange, this.showBestOnly});

  final PriceRangeFilter? priceRange;
  final BestOfferFilter? showBestOnly;

  List<ProductFilter> get allFilters => [
        if (priceRange != null) priceRange!,
        if (showBestOnly != null) showBestOnly!,
      ];

  FiltersState copyWith({PriceRangeFilter? Function()? priceRange, BestOfferFilter? Function()? showBestOnly}) {
    return FiltersState(
      priceRange: priceRange != null ? priceRange() : this.priceRange,
      showBestOnly: showBestOnly != null ? showBestOnly() : this.showBestOnly,
    );
  }
}

class FiltersCubit extends Cubit<FiltersState> {
  FiltersCubit() : super(const FiltersState());

  void setPriceRange(PriceRange priceRange) {
    emit(state.copyWith(priceRange: () => PriceRangeFilter(priceRange: priceRange)));
  }

  void setShowBestOnly(bool showBestOnly) {
    emit(state.copyWith(showBestOnly: () => showBestOnly ? BestOfferFilter() : null));
  }

  void clearFilters() {
    emit(state.copyWith(priceRange: () => null, showBestOnly: () => null));
  }
}
