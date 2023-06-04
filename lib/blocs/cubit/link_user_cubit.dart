import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wibinx_app/services/link_user_service.dart';

part 'link_user_state.dart';

class LinkUserCubit extends Cubit<LinkUserState> {
  LinkUserCubit() : super(LinkUserInitial());

  updateMultipleLinkUser(Map<String, dynamic> request) async {
    emit(LinkUserLoading());
    var response = await LinkUserService().updateMultipleLinkUser(request);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      
      emit(LinkUserSuccess(data['message']));
    } else {
      print(response.body);
      var data = json.decode(response.body);
      emit(LinkUserFailed(data));
    }
  }
}


