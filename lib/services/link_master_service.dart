import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wibinx_app/models/link_master_model.dart';
import 'package:wibinx_app/shared/helper.dart';


class LinkMasterService {
  final storage = const FlutterSecureStorage();

  Future<List<LinkMasterModel>> getLinkMaster() async {
    var token = await storage.read(key: 'token');

    var response = await http.get(Uri.parse(baseUrl + 'api/link-masters'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token.toString(),
        }
    );

    if(response.statusCode != 200) return [];
    var data = json.decode(response.body)['data'] as List;

    if(data.length == 0) {
      return [];
    }

    List<LinkMasterModel> linkMasters = data.map((item) => LinkMasterModel.fromJson(item)).toList();
    
    return linkMasters;
  }

}
