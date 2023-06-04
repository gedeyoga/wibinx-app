import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wibinx_app/shared/helper.dart';


class AuthService {
  final storage = const FlutterSecureStorage();

  Future signIn(String email, String password) async {
    var response = await http.post(Uri.parse(baseUrl + 'api/login'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});

    return response;
  }

  Future getAuthProfile(int user_id) async {
     var token = await storage.read(key: 'token');

    var response = await http.get(
      Uri.parse(baseUrl + 'api/user/' + user_id.toString()),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token.toString(),
      },
    );

    return response;
  }

  Future updateUser(String user_id , String name, String email, String? password , bool changePassword) async {
     var token = await storage.read(key: 'token');

    var response = await http.put(
      Uri.parse(baseUrl + 'api/user/' + user_id.toString()),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token.toString(),
      },
      body: {
        'id': user_id,
        'name': name,
        'email': email,
        'password': password,
        'change_password': changePassword ? '1' : '0',
      }
    );

    return response;
  }

  Future register(Map<String, dynamic> request) async {
    var response = await http.post(Uri.parse(baseUrl + 'api/register'),
      headers: {'Accept': 'application/json'},
      body: {
        'name' : request['name'],
        'email' : request['email'],
        'password' : request['password'],
        'password_confirmation' : request['password'],
      }
    );

    return response;
  }
}
