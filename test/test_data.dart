import 'dart:convert';

import 'package:flutter_recruitment_task/models/products_page.dart';

ProductsPage aProductPage({int totalPages = 1, int pageNumber = 1, int pageSize = 1, List<Product>? products}) =>
    ProductsPage(totalPages: totalPages, pageNumber: pageNumber, pageSize: pageSize, products: products ?? [aProduct]);

Product aProduct = Product.fromJson(
  jsonDecode("""
{
      "id": "aProduct",
      "name": "OneDayMore Musli owocowe 3xTuba 400g",
      "description": "",
      "available": true,
      "offer": {
        "sellerId": "seller075",
        "sellerName": "seller075",
        "skuId": "11242",
        "regularPrice": {
          "amount": 51,
          "currency": "PLN"
        },
        "promotionalPrice": {
          "amount": 2,
          "currency": "PLN"
        },
        "normalizedPrice": {
          "amount": 4.25,
          "currency": "PLN",
          "unitLabel": "/100g"
        },
        "promotionalNormalizedPrice": {
          "amount": 0.17,
          "currency": "PLN",
          "unitLabel": "/100g"
        },
        "omnibusFrom": "2023-11-22",
        "omnibusPrice": {
          "amount": 45,
          "currency": "PLN"
        },
        "omnibusLabel": "Najniższa cena z 30 dni przed obniżką",
        "isBest": false,
        "isSponsored": false,
        "subtitle": ""
      },
      "mainImage": "",
      "tags": [
        {
          "color": "#EC0677",
          "label": "%",
          "tag": "promotion",
          "labelColor": "#FFFFFF"
        }
      ],
      "sellerId": "seller075",
      "isFavorite": false,
      "isBlurred": false
    }"""),
);

Product productWithPrice100 = Product.fromJson(
  jsonDecode("""
{
      "id": "productWithPrice100",
      "name": "OneDayMore Musli owocowe 3xTuba 400g",
      "description": "",
      "available": true,
      "offer": {
        "sellerId": "seller075",
        "sellerName": "seller075",
        "skuId": "11242",
        "regularPrice": {
          "amount": 100,
          "currency": "PLN"
        },
        "normalizedPrice": {
          "amount": 4.25,
          "currency": "PLN",
          "unitLabel": "/100g"
        },
        "omnibusFrom": "2023-11-22",
        "omnibusPrice": {
          "amount": 45,
          "currency": "PLN"
        },
        "omnibusLabel": "Najniższa cena z 30 dni przed obniżką",
        "isBest": false,
        "isSponsored": false,
        "subtitle": ""
      },
      "mainImage": "",
      "tags": [
        {
          "color": "#EC0677",
          "label": "%",
          "tag": "promotion",
          "labelColor": "#FFFFFF"
        }
      ],
      "sellerId": "seller075",
      "isFavorite": false,
      "isBlurred": false
    }"""),
);
