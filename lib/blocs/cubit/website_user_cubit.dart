import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wibinx_app/models/website_user_model.dart';
import 'package:wibinx_app/services/website_user_service.dart';

part 'website_user_state.dart';

class WebsiteUserCubit extends Cubit<WebsiteUserState> {
  WebsiteUserCubit() : super(WebsiteUserInitial());
  
  store(Map<String, dynamic> request) async  {
      var response = await WebsiteUserService().storeWebsiteUser(request);

      emit(WebsiteUserLoading());

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        WebsiteUserModel websiteUser = WebsiteUserModel.fromJson(data['user']['websites'][0]);

        emit(WebsiteUserSuccess(websiteUser, data['message']));
      } else {
        var data = json.decode(response.body);
        emit(WebsiteUserFailed(data));
      }
  }

  update(Map<String, dynamic> request) async  {
      var response = await WebsiteUserService().updateWebsiteUser(request);

      emit(WebsiteUserLoading());

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        WebsiteUserModel websiteUser = WebsiteUserModel.fromJson(data['user']['websites'][0]);

        emit(WebsiteUserSuccess(websiteUser, data['message']));
      } else {
        var data = json.decode(response.body);
        emit(WebsiteUserFailed(data));
      }
  }

  void linkType(String link) {
    emit(WebsiteUserLoading());
    emit(LinkNameTyping(link));
  }


}
