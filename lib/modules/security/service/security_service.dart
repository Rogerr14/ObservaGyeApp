import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/environment.dart';
import 'package:observa_gye_app/modules/security/login/model/user_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/models/general_response.dart';
import 'package:observa_gye_app/shared/services/http_interceptor.dart';

class SecurityService {
  InterceptorHttp interceptorHttp = InterceptorHttp();
  String url = Environment().config?.serviceUrl ?? '';

  Future<GeneralResponse<UserModel>> login(
      BuildContext context, dynamic body) async {
    try {
      final urlEndpoint = "$url/Usuario/IniciarSesion";
      UserModel? loginResponse;

      final response =
          await interceptorHttp.request(context, 'POST', urlEndpoint, body);
      GlobalHelper.logger.w('llega aqui');
      if (!response.error) {
        GlobalHelper.logger.w(jsonEncode(response.data));
        loginResponse = userModelFromJson(jsonEncode(response.data));
        return GeneralResponse(
            message: response.message,
            error: response.error,
            data: loginResponse);
      }

      return GeneralResponse(message: response.message, error: response.error);
    } catch (e) {
      GlobalHelper.logger.w("error: $e");
      return GeneralResponse(message: 'Error al iniciar Sesion', error: true);
    }
  }

  Future<GeneralResponse> createAccount(
      BuildContext context, dynamic body) async {
    final urlEndpoint = "$url/Usuario/Crear";
    try {
      final response =
          await interceptorHttp.request(context, 'POST', urlEndpoint, body);
      if (!response.error) {
        return GeneralResponse(
          message: response.message,
          error: false,
        );
      }

      return GeneralResponse(message: response.message, error: response.error);
    } catch (e) {
      GlobalHelper.logger.w("erro: $e");
      return GeneralResponse(
          message: 'Errro al Registrar usuario', error: true);
    }
  }
}
