import 'package:flutter/material.dart';
import 'package:pos_si2_movil/screens/productosScreen.dart';

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _pageController;
    int _currentIndex = 0;

    void _onItemTapped(int index) {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        automaticallyImplyLeading: false,
        title: const Text('PointSync System',
            style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              // Aquí puedes manejar la selección del menú
              if (result == 'cerrarCaja') {
                //Aqui se cierra la caja
                Navigator.pushNamed(context, '/login');
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
          //Y hacer algo aca xd
          //
        },
        //colocar las paginas que tienen que seleccionarse en la barra de abajo del menu xd --------------------------------------
        //-------------------------------------------
        children: [ProductosScreen()],
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
            icon: Icon(Icons.monetization_on),
            label: 'Reportes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Caja',
          ),
        ],
      ),
    );
  }
}
