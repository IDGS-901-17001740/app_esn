import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:muebleria_valadez/screens/screen.dart';

class ListItem extends StatefulWidget {
  final String nombre;
  final String descripcion;
  final int idProducto;
  final int idUsuario;
  final List usuario;
  final String foto;
  const ListItem({
    Key? key,
    required this.nombre,
    required this.descripcion,
    required this.idProducto,
    required this.idUsuario,
    required this.usuario,
    required this.foto,
  }) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => DetalleProductoScreen(
                  nombreProducto: widget.nombre,
                  descripcion: widget.descripcion,
                  idProducto: widget.idProducto,
                  idUsuario: widget.idUsuario,
                  usuario: widget.usuario,
                ),
              ),
              (Route<dynamic> route) => true,
            ).then((value) {
              setState(() {});
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const Image(
                      image: AssetImage('assets/Logo.png'), fit: BoxFit.cover),
                ),
                const SizedBox(height: 10),
                const Text('Producto:', style: TextStyle(fontSize: 15)),
                Text(widget.nombre, style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
