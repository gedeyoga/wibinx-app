import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wibinx_app/models/product_model.dart';
import 'package:wibinx_app/services/product_service.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  store(Map<String, dynamic> request) async {

    emit(ProductLoading());
    var response = await ProductService().storeProduct(request);


    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // ProductModel product =
      //     ProductModel.fromJson(data['user']['websites'][0]);

      emit(ProductSuccess(data['message']));
    } else {
      var data = json.decode(response.body);
      emit(ProductFailed(data));
    }
  }

  update(Map<String, dynamic> request) async {
    var response = await ProductService().updateProduct(request);

    emit(ProductLoading());

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // ProductModel product =
      //     ProductModel.fromJson(data['user']['websites'][0]);

      emit(ProductSuccess(data['message']));
    } else {
      var data = json.decode(response.body);
      emit(ProductFailed(data));
    }
  }

  delete(int product_id) async {
    var response = await ProductService().deleteProduct(product_id);

    emit(ProductLoading());

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      emit(ProductDeleted(data['message']));
    } else {
      var data = json.decode(response.body);
      emit(ProductFailed(data));
    }
  }
}
