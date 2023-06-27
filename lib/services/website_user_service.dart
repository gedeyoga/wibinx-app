import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wibinx_app/shared/helper.dart';

class WebsiteUserService {
  final storage = const FlutterSecureStorage();

  Future storeWebsiteUser(Map<String, dynamic> request) async {
    var token = await storage.read(key: 'token');

    var api = await http.MultipartRequest(
      'POST',
      Uri.parse(baseUrl + 'api/website-users'),
    )
      ..fields['name'] = request['name']
      ..fields['user_id'] = request['user_id']
      ..fields['link_name'] = request['link_name']
      ..fields['description'] = request['description']
      ..fields['theme_id'] = request['theme_id'].toString()
      ;
    api.headers['Authorization'] = 'Bearer ' + token.toString();
    api.headers['Accept'] = 'application/json';
    
    if(request['logo'] is XFile) {
      api.files.add(await http.MultipartFile.fromPath(
          'logo', request['logo'].path));
    }

    var streamedResponse = await api.send();

    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  Future updateWebsiteUser(Map<String, dynamic> request) async {
    var token = await storage.read(key: 'token');

    var api = await http.MultipartRequest(
      'POST',
      Uri.parse(
          baseUrl + 'api/website-users/' + request['id'].toString() + '/'),
      
    )

      ..fields['_method'] = 'PUT'
      ..fields['name'] = request['name']
      ..fields['user_id'] = request['user_id']
      ..fields['link_name'] = request['link_name']
      ..fields['description'] = request['description']
      ..fields['theme_id'] = request['theme_id'].toString();

      if (request['logo'] is XFile) {
        api.files
            .add(await http.MultipartFile.fromPath('logo', request['logo'].path));
      }
      
      api.headers['Authorization'] = 'Bearer ' + token.toString();
      api.headers['Accept'] = 'application/json';

      var streamedResponse = await api.send();

      var response = await http.Response.fromStream(streamedResponse);

    return response;
  }
}
