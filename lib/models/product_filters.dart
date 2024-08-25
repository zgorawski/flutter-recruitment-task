import 'package:flutter_recruitment_task/models/products_page.dart';

typedef PriceRange = ({double? from, double? to});

abstract class ProductFilter {
  bool isSatisfiedBy({required Product product});
}

class PriceRangeFilter implements ProductFilter {
  PriceRangeFilter({required this.priceRange});

  final PriceRange priceRange;

  @override
  bool isSatisfiedBy({required Product product}) {
    final productPrice = (product.offer.promotionalPrice ?? product.offer.regularPrice).amount;
    if (priceRange.from != null && productPrice < priceRange.from!) return false;
    if (priceRange.to != null && productPrice > priceRange.to!) return false;
    return true;
  }
}

class BestOfferFilter implements ProductFilter {
  @override
  bool isSatisfiedBy({required Product product}) {
    return product.offer.isBest == true;
  }
}
