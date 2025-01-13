import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/environment.dart';
import 'package:observa_gye_app/modules/security/login/model/user_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/models/general_response.dart';
import 'package:observa_gye_app/shared/services/http_interceptor.dart';

class UserService {
  InterceptorHttp interceptorHttp = InterceptorHttp();
  String urlService = Environment().config?.serviceUrl ?? '';

  Future<GeneralResponse> changePassword(BuildContext context, dynamic body)async{
    final urlEndpoint = '$urlService/Usuario/cambiarContrasena';

    try {
      
      final response = await interceptorHttp.request(context, 'POST', urlEndpoint, body);
      if(!response.error){
        return GeneralResponse(message: response.message, error: response.error);
      }

      return GeneralResponse(message: response.message, error: true);
    } catch (e) {
      GlobalHelper.logger.e('Error al cambiar contraseña $e');
      return GeneralResponse(message: 'Error al cambiar contraseña', error: true);
    }
  }



  Future<GeneralResponse<UserModel>> modifyUser(BuildContext context, dynamic body)async{
    final urlEndpoint = '$urlService/Usuario/EditUserData';
    try {
      final response = await interceptorHttp.request(context, 'POST', urlEndpoint, body);
      UserModel? userModel;
      if(!response.error){
        userModel = userModelFromJson(jsonEncode(response.data));

        return GeneralResponse(message: response.message, error: response.error, data: userModel );
      }

      return GeneralResponse(message: response.message, error: response.error, data: null);
    } catch (error) {
      GlobalHelper.logger.e('Error al modificar datos $error');
      return GeneralResponse(message: 'Error al modificar datos $error', error: true); 
    }
  }

}