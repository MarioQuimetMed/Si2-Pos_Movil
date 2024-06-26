import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pos_si2_movil/Widgets/Producto.dart';
import 'package:pos_si2_movil/Widgets/productoDialog.dart';
import 'package:pos_si2_movil/api/productoApi.dart';

class ProductosScreen extends StatefulWidget {
  ProductosScreen({super.key});

  @override
  _ProductosScreenState createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  static String? baseUrl = dotenv.env['AZURE_URL'];
  List<Producto> _productos = [];
  final TextEditingController _searchController = TextEditingController();
  final productoApi = ProductoApi();
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    getProductos();
  }

  Future<void> getProductos() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      // Simular una espera
      final response = await productoApi.getProducto();
      // Aquí debes llamar a la API real para obtener los productos
      _productos = response;
    } catch (e) {
      _errorMessage = 'Error al cargar productos';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> buscarProducto() async {
    // Implementar la lógica de búsqueda
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar productos...',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  buscarProducto();
                },
              ),
            ),
            onSubmitted: (value) {
              buscarProducto();
            },
          ),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _errorMessage.isNotEmpty
                ? Center(
                    child: Text(_errorMessage),
                  )
                : _productos.isEmpty
                    ? const Center(
                        child: Text('No hay productos disponibles'),
                      )
                    : ListView.builder(
                        itemCount: _productos.length,
                        itemBuilder: (context, index) {
                          final producto = _productos[index];
                          final precioConDescuento = producto.precio -
                              (producto.precio * (producto.descuento / 100));

                          return InkWell(
                            onTap: () {
                              // Implementar la acción al presionar el botón
                              if (producto.cantidad == 0) {
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      true, // Permite cerrar el diálogo al tocar fuera de él.
                                  barrierColor: Colors.black
                                      .withOpacity(0.5), // Fondo translúcido.
                                  builder: (BuildContext context) {
                                    return ProductoDialog(
                                      // Asegúrate de que ProductoDialog sea un widget.
                                      nombre: producto.nombre,
                                      precio: producto.precio,
                                      descuento: producto.descuento,
                                      id: producto.id,
                                    );
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Producto agotado'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: Card(
                              margin: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8.0),
                                leading: Image.network(
                                  '$baseUrl${producto.imageUrl!}',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  producto.nombre,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(producto.descripcion!),
                                    const SizedBox(height: 4.0),
                                    if (producto.descuento > 0) ...[
                                      Row(
                                        children: [
                                          Text(
                                            '\$${producto.precio.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.red,
                                            ),
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            '\$${precioConDescuento.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ] else ...[
                                      Text(
                                        '\$${producto.precio.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }
}
