import 'package:flutter/material.dart';
import 'package:muebleria_valadez/provider/util_provider.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class LoginProvider extends ChangeNotifier {
  final _urlBase = 'https://192.168.100.6:7010';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> usuarios = [];
  Future login({required String usuario, required String password}) async {
    String url = '$_urlBase/auth/Auth/login';

    // Convertir la cadena original en bytes
    List<int> originalBytes = utf8.encode(password);

    // Calcular el hash SHA-512
    Digest sha512Result = sha512.convert(originalBytes);

    // Convertir el resultado a una representación hexadecimal
    String hashHex = sha512Result.toString();

    /* print('Texto original: $password');
    print('Hash SHA-512: $hashHex'); */

    final body = {"email": usuario, "password": hashHex};

    var response =
        await UtilProvider.rtp.responseHTTP_Post(urlBase: url, data: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jResponse = jsonDecode(response.body);

      for (var item in jResponse) {
        if (item is Map<String, dynamic>) {
          usuarios.add(item);
        }
      }

      print(usuarios);
      notifyListeners();
      return usuarios;
    } else {
      return [];
    }
  }
}
