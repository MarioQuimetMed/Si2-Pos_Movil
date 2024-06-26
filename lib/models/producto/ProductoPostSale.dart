// To parse this JSON data, do
//
//     final productPostSale = productPostSaleFromJson(jsonString);

import 'dart:convert';

ProductPostSale productPostSaleFromJson(String str) =>
    ProductPostSale.fromJson(json.decode(str));

String productPostSaleToJson(ProductPostSale data) =>
    json.encode(data.toJson());

class ProductPostSale {
  List<Product> products;

  ProductPostSale({
    required this.products,
  });

  factory ProductPostSale.fromJson(Map<String, dynamic> json) =>
      ProductPostSale(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };

  List<Map<String, dynamic>> getFormattedProducts() {
    return products.map((product) {
      return {
        "productId": product.productId,
        "cant": product.cant,
      };
    }).toList();
  }
}

class Product {
  int productId;
  int cant;

  Product({
    required this.productId,
    required this.cant,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        cant: json["cant"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "cant": cant,
      };
}
