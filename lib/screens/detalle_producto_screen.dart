// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:muebleria_valadez/provider/productos_provider.dart';
import 'package:muebleria_valadez/screens/screen.dart';
import 'package:muebleria_valadez/theme/app_theme.dart';
import 'package:muebleria_valadez/util/util.dart';
import 'package:provider/provider.dart';

class DetalleProductoScreen extends StatelessWidget {
  final String nombreProducto;
  final String descripcion;
  final int idProducto;
  final int idUsuario;
  final List usuario;
  const DetalleProductoScreen({
    super.key,
    required this.nombreProducto,
    required this.descripcion,
    required this.idProducto,
    required this.idUsuario,
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    final productoProvider = Provider.of<ProductoProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppTheme.sixth,
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                child: const Text(''),
              ),
              background: const FadeInImage(
                placeholder: AssetImage('assets/cargando.gif'),
                fit: BoxFit.cover,
                image: AssetImage('assets/Logo.png'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nombreProducto, style: const TextStyle(fontSize: 25)),
                    const SizedBox(height: 30),
                    Text(descripcion, style: const TextStyle(fontSize: 25)),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: AppTheme.red,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPressed: () async {
              bool res = await productoProvider.eliminarProducto(
                idProducto: idProducto,
                idUsuario: idUsuario,
              );
              if (res == false) {
                Dialogos.msgDialog(
                        context: context,
                        color: const Color.fromARGB(255, 206, 66, 56),
                        texto: 'Datos Incorrectos, intenta de nuevo',
                        dgt: DialogType.error,
                        onPress: () {
                          //Navigator.pushNamed(context, '/');
                        })
                    .show();
              } else {
                Dialogos.msgDialog(
                    context: context,
                    texto: 'Producto Eliminado',
                    dgt: DialogType.success,
                    onPress: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MainScreen(
                            usuario: usuario,
                          ),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }).show();
              }
            },
          ),
        ),
      ),
    );
  }
}
