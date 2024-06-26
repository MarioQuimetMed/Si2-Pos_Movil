import 'package:flutter/material.dart';
import 'package:pos_si2_movil/screens/Menu/caja/cajaScreen.dart';
import 'package:pos_si2_movil/screens/Menu/productos/productosScreen.dart';
import 'package:pos_si2_movil/screens/devolucionScreen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        automaticallyImplyLeading: false,
        title: const Text(
          'PointSync System',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              // Manejar la selección del menú
              if (result == 'cerrarCaja') {
                Navigator.pushNamed(context, '/cierreCaja');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'cerrarCaja',
                child: Text('Cerrar Caja'),
              ),
            ],
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          ProductosScreen(),
          DevolucionesScreen(),
          CajaScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Devoluciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Caja',
          ),
        ],
        selectedItemColor: Colors.blue, // Color del ícono seleccionado
        unselectedItemColor:
            Colors.grey, // Color de los íconos no seleccionados
        showUnselectedLabels: true,
      ),
    );
  }
}
