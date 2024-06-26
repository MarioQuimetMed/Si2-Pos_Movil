// To parse this JSON data, do
//
//     final getProductResponse = getProductResponseFromJson(jsonString);

import 'dart:convert';

GetProductResponse getProductResponseFromJson(String str) =>
    GetProductResponse.fromJson(json.decode(str));

String getProductResponseToJson(GetProductResponse data) =>
    json.encode(data.toJson());

class GetProductResponse {
  int statusCode;
  String message;
  Data data;

  GetProductResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetProductResponse.fromJson(Map<String, dynamic> json) =>
      GetProductResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int total;
  List<ProductElement> products;

  Data({
    required this.total,
    required this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        products: List<ProductElement>.from(
            json["products"].map((x) => ProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class ProductElement {
  int cant;
  Stock stock;

  ProductElement({
    required this.cant,
    required this.stock,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        cant: json["cant"],
        stock: Stock.fromJson(json["stock"]),
      );

  Map<String, dynamic> toJson() => {
        "cant": cant,
        "stock": stock.toJson(),
      };
}

class Stock {
  int id;
  StockProduct product;

  Stock({
    required this.id,
    required this.product,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        id: json["id"],
        product: StockProduct.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
      };
}

class StockProduct {
  int id;
  List<Category> categories;
  List<String> images;
  String name;
  String price;
  String discount;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  StockProduct({
    required this.id,
    required this.categories,
    required this.images,
    required this.name,
    required this.price,
    required this.discount,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StockProduct.fromJson(Map<String, dynamic> json) => StockProduct(
        id: json["id"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        images: List<String>.from(json["images"].map((x) => x)),
        name: json["name"],
        price: json["price"],
        discount: json["discount"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x)),
        "name": name,
        "price": price,
        "discount": discount,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Category {
  int categoryId;
  int productId;

  Category({
    required this.categoryId,
    required this.productId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"],
        productId: json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "productId": productId,
      };
}
