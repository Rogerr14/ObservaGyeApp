import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/environment.dart';
import 'package:observa_gye_app/modules/security/login/model/login_response_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/models/general_response.dart';
import 'package:observa_gye_app/shared/services/http_interceptor.dart';

class SecurityService {

  InterceptorHttp interceptorHttp = InterceptorHttp();
  String url =  Environment().config?.serviceUrl ?? '';
  

  Future<GeneralResponse<LoginResponse>> login(BuildContext context, dynamic body)async{

    try {
      final urlEndpoint = "${url}api/Usuario/IniciarSesion";
      LoginResponse? loginResponse;

      final response = await interceptorHttp.request(context, 'POST', urlEndpoint, body);
      if(!response.error){
        loginResponse = loginResponseFromJson(jsonEncode(response.data));
        return GeneralResponse(message: response.message, error: response.error, data: loginResponse);
      }

      return GeneralResponse(message: response.message, error: response.error);

      
    } catch (e) {
      GlobalHelper.logger.w("erro: $e");
      return GeneralResponse(message: 'Errro al iniciar Sesion', error: true);
    }

  }





}