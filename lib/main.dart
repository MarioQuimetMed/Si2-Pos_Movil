import 'package:flutter/material.dart';
import 'package:pos_si2_movil/Widgets/cartProvider.dart';
import 'package:pos_si2_movil/provider/authProvider.dart';
import 'package:pos_si2_movil/screens/auth/aperturaCajaScreen.dart';
import 'package:pos_si2_movil/screens/Menu/caja/cierreCajaScreen.dart';
import 'package:pos_si2_movil/screens/auth/loginScreen.dart';
import 'package:pos_si2_movil/screens/Menu/mainMenuScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => CartProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // Configurar nombres de rutas
        routes: {
          '/menu': (context) => MainMenuScreen(),
          '/login': (context) => LoginScreen(),
          '/apertura': (context) => AperturaScreen(),
          '/cierreCaja': (context) => CierreCajaScreen(),
        },
        home: LoginScreen(),
      ),
    );
  }
}
