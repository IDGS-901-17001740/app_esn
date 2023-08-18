import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muebleria_valadez/provider/util_provider.dart';

class ProductoProvider extends ChangeNotifier {
  final _urlBase = 'https://192.168.100.6:7010';

  List<dynamic> productos = [];

  Future getProductos() async {
    String url = '$_urlBase/api/Productos';
    final response = await UtilProvider.rtp.responseHTTP(urlBase: url);

    if (response.statusCode == 200) {
      var jResponse = jsonDecode(response.body);
      List<dynamic> fetchedProductos = [];

      for (var item in jResponse) {
        if (item is Map<String, dynamic>) {
          fetchedProductos.add(item);
        }
      }

      productos = fetchedProductos;

      // Llama a notifyListeners() aquí para notificar a los listeners
      notifyListeners();

      return productos;
    } else if (response.statusCode == 408) {
      // ignore: avoid_print
      print('No hay datos');
    } else {
      return 'Error';
    }
  }

  bool isDelete = false;

  Future<bool> eliminarProducto(
      {required int idProducto, required int idUsuario}) async {
    String url = '$_urlBase/api/Productos/$idProducto/$idUsuario';

    var response = await UtilProvider.rtp.responseHTTP_delete(urlBase: url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      isDelete = true;
      notifyListeners();
      return isDelete;
    } else {
      notifyListeners();
      return isDelete;
    }
  }
}
