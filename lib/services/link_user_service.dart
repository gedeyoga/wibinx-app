import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wibinx_app/shared/helper.dart';


class LinkUserService {
  final storage = const FlutterSecureStorage();

  Future updateMultipleLinkUser(Map<String, dynamic> request) async {
    var token = await storage.read(key: 'token');

    // Map<String ,dynamic> formData = {};

    // for (var i = 0; i < request['data'].length; i++) {
    //   formData.addAll({
    //     "data[$i]" : request['data'][i],
    //   });
    // }
    
    var response = await http.post(Uri.parse(baseUrl + 'api/link-users/update-multiple'),
        headers: {
          'Authorization': 'Bearer ' + token.toString(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request),
    );

    return response;
  }
}
