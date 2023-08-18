import 'package:flutter/material.dart';
import 'package:muebleria_valadez/provider/productos_provider.dart';
import 'package:muebleria_valadez/theme/app_theme.dart';
import 'package:muebleria_valadez/widget/widgets.dart';
import 'package:provider/provider.dart';

import '../widget/drawer_widget.dart';

class MainScreen extends StatefulWidget {
  final List usuario;
  const MainScreen({super.key, required this.usuario});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    getProductos();
    super.initState();
  }

  getProductos() async {
    final productoProvider =
        Provider.of<ProductoProvider>(context, listen: false);
    List<dynamic> fetchedProductos = await productoProvider.getProductos();

    setState(() {
      productos = fetchedProductos;
    });

    for (var item in productos) {
      print(item['nombreProducto'].toString() + item['estatus'].toString());
    }
  }

  List<dynamic> productos = [];
  @override
  Widget build(BuildContext context) {
    final String nombre = widget.usuario[0]['nombres'].toString();
    final String apePaterno = widget.usuario[0]['apellidoPaterno'].toString();
    final String apeMaterno = widget.usuario[0]['apellidoMaterno'].toString();
    final int idUsuario = widget.usuario[0]['idUsuario'];
    final String nombreCompleto = '$nombre $apePaterno $apeMaterno';

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.sixth,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.primary,
        ),
        endDrawer: DrawerWidget(nombre: nombreCompleto),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: const Text(
                          'Todos los Productos',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      if (productos.isEmpty)
                        const Center(
                          child: CircularProgressIndicator(
                              color: AppTheme.primary),
                        )
                      else
                        for (var item in productos)
                          ListItem(
                            nombre: item['nombreProducto'].toString(),
                            descripcion: item['descripcion'].toString(),
                            idProducto: item['idProducto'],
                            idUsuario: idUsuario,
                            usuario: widget.usuario,
                            foto: item['foto'].toString(),
                          ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
