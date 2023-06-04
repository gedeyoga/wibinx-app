import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wibinx_app/shared/helper.dart';


class WebsiteUserService {
  final storage = const FlutterSecureStorage();

  Future storeWebsiteUser(Map<String, dynamic> request) async {
    var token = await storage.read(key: 'token');

    var response = await http.post(Uri.parse(baseUrl + 'api/website-users'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token.toString(),

        },
        body: {
          'name': request['name'], 
          'user_id': request['user_id'], 
          'link_name': request['link_name'], 
          'description': request['description'], 
        });

    return response;
  }

  Future updateWebsiteUser( Map<String , dynamic> request) async {

    var token = await storage.read(key: 'token');


    var response = await http.post(
        Uri.parse(baseUrl + 'api/website-users/'  + request['id'].toString() + '/'),
        // Uri.parse(baseUrl + 'api/website-users'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token.toString(),

        },
        body: {
          '_method' : 'PUT',
          'name': request['name'], 
          'user_id': request['user_id'].toString(), 
          'link_name': request['link_name'], 
          'description': request['description'], 
          'theme_id': request['theme_id'].toString(), 
        });

    return response;

  }
}