// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UtilProvider extends ChangeNotifier {
  static final UtilProvider rtp = UtilProvider._();
  // ._ permite que se pueda emplear en cualquier parte de la app
  UtilProvider._();

  // Response HTTP
  Future responseHTTP({required String urlBase}) async {
    var response = await http.get(Uri.parse(urlBase));
    return response;
  }

  Future responseHTTP_Post(
      {required String urlBase, required Map<String, dynamic> data}) async {
    final headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    var response = await http.post(Uri.parse(urlBase),
        body: jsonEncode(data), headers: headers);
    return response;
  }

  Future responseHTTP_delete({required String urlBase}) async {
    //final headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    var response = await http.delete(Uri.parse(urlBase));
    return response;
  }
}
