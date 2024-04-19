import 'package:flutter/material.dart';
import 'package:pos_si2_movil/provider/authProvider.dart';
import 'package:pos_si2_movil/screens/loginScreen.dart';
import 'package:pos_si2_movil/screens/mainMenuScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
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
        },
        home: LoginScreen(),
      ),
    );
  }
}
