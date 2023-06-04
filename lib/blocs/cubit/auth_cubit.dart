import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wibinx_app/models/user_model.dart';
import 'package:wibinx_app/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final storage = const FlutterSecureStorage();

  signIn(String email , String password) async {

    emit(AuthLoading());
    var response = await AuthService().signIn(email, password);

    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      saveToken(data['data']['token']);

      var token = await storage.read(key: 'token');
      await storage.write(key: 'userId', value: data['data']['account']['id'].toString());

      emit(AuthSuccess(data , token != null));
    }else {
      var data = json.decode(response.body);
      emit(AuthFailed(data));
    }
  }

  void saveToken(String dataToken) async {

    await storage.write(key: 'token', value: dataToken);

  }

  void logout() async {
    await storage.delete(key: 'token');
  }

  Future authProfile(int userId) async{
    var response = await AuthService().getAuthProfile(userId);

    emit(AuthLoading());

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      UserModel user = UserModel.fromJson(data['data']);
      emit(AuthProfile(user));
    } 
  }
  
  Future updateUser(String userId , String name, String email, String? password , bool changePassword) async{
    var response = await AuthService().updateUser(userId , name, email, password, changePassword);

    emit(AuthLoading());

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      UserModel user = UserModel.fromJson(data['data']);
      emit(AuthUpdate(user , data['message']));
    } 
  }

  register(Map<String, dynamic> request) async {
    emit(AuthLoading());
    var response = await AuthService().register(request);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      saveToken(data['data']['token']);

      var token = await storage.read(key: 'token');
      await storage.write(
          key: 'userId', value: data['data']['account']['id'].toString());

      emit(AuthSuccess(data, token != null));
    } else {
      var data = json.decode(response.body);
      emit(AuthFailed(data));
    }
  }

}
