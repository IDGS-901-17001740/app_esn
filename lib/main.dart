import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muebleria_valadez/provider/productos_provider.dart';
import 'package:muebleria_valadez/router/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  //Deshabilitar la verificación del certificado SSL
  HttpOverrides.global = MyHttpOverrides();

  //Crear instancia de http.Client
  //http.Client client = http.Client();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      // Este widget permite varios providers
      providers: [
        ChangeNotifierProvider(
            // (_) no le estas mandando nada a la función
            create: (_) => ProductoProvider())
      ],
      child: MaterialApp(
        title: 'Muebleria Valadez',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.initialRouter,
        routes: AppRoutes.routes,
        // En caso de que no encuentre la vista mostrará un error
        onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(settings),
      ),
    );
  }
}
