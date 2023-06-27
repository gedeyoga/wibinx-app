import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wibinx_app/shared/helper.dart';

class ProductService {
  final storage = const FlutterSecureStorage();

  Future storeProduct(Map<String, dynamic> request) async {
    var token = await storage.read(key: 'token');

    var api = await http.MultipartRequest(
      'POST',
      Uri.parse(
          baseUrl + 'api/product'),
    )
      // ..fields['_method'] = 'PUT'
      ..fields['name'] = request['name']
      ..fields['description'] = request['description']
      ..fields['harga'] = request['harga']
      ..fields['section_id'] = request['section_id'].toString()
      ..fields['link_product'] = request['link_product'];

    if (request['image'] is XFile) {
      api.files
          .add(await http.MultipartFile.fromPath('image', request['image'].path));
    }

    api.headers['Authorization'] = 'Bearer ' + token.toString();
    api.headers['Accept'] = 'application/json';

    var streamedResponse = await api.send();

    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  Future updateProduct(Map<String, dynamic> request) async {
    var token = await storage.read(key: 'token');

    var api = await http.MultipartRequest(
      'POST',
      Uri.parse(
          baseUrl + 'api/product/' + request['id'].toString() + ''),
    )
      ..fields['_method'] = 'PUT'
      ..fields['name'] = request['name']
      ..fields['description'] = request['description']
      ..fields['harga'] = request['harga']
      ..fields['section_id'] = request['section_id'].toString()
      ..fields['link_product'] = request['link_product'];


    if (request['image'] is XFile) {
      print(request['image']);
      api.files
          .add(await http.MultipartFile.fromPath('image', request['image'].path));
    }

    api.headers['Authorization'] = 'Bearer ' + token.toString();
    api.headers['Accept'] = 'application/json';

    var streamedResponse = await api.send();

    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  Future deleteProduct(int product_id) async {
    var token = await storage.read(key: 'token');

    var response = await http.delete(Uri.parse(baseUrl + 'api/product/' + product_id.toString()),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token.toString(),
        }
    );

    return response;
  }
}
