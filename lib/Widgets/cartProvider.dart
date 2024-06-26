import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:pos_si2_movil/Widgets/Producto.dart';

class ProductoCart {
  final Producto producto;
  int quantity;

  ProductoCart({required this.producto, required this.quantity});

  void incrementarCantidad() {
    quantity++;
  }

  void decrementarCantidad() {
    if (quantity > 0) {
      quantity--;
    }
  }
}

class CartProvider with ChangeNotifier {
  List<ProductoCart> _items = [];
  List<ProductoCart> get items => _items;

  void addItem(Producto producto, int quantity) {
    // Buscar si el producto ya existe en el carrito
    ProductoCart? existingProduct = _items.firstWhereOrNull(
      (productoCart) => productoCart.producto == producto,
    );

    if (existingProduct != null) {
      // Si el producto ya existe, aumentar su cantidad
      existingProduct.quantity += quantity;
    } else {
      // Si el producto no existe, agregarlo al carrito
      ProductoCart productoCart =
          ProductoCart(producto: producto, quantity: quantity);
      _items.add(productoCart);
    }

    notifyListeners();
  }

  void incrementQuantity(Producto product) {
    var index = _items.indexWhere((item) => item.producto == product);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(ProductoCart product) {
    final item = _items.firstWhereOrNull((item) => item == product);
    item?.decrementarCantidad();
    if (item?.quantity == 0) {
      removeItem(item!);
    }
    notifyListeners();
  }

  void removeItem(ProductoCart product) {
    _items.remove(product);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
