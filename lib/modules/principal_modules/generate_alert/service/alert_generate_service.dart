import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:observa_gye_app/env/environment.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/models/general_response.dart';
import 'package:observa_gye_app/shared/services/http_interceptor.dart';

class AlertGenerateService {
  InterceptorHttp interceptorHttp = InterceptorHttp();
  final String urlService = Environment().config?.serviceUrl ?? '';

  Future<GeneralResponse> sendAlertReport(BuildContext context,
      List<MultipartFile> files, Map<String, String> fields) async {
    final urlEndpoint = '$urlService/Alerta/CrearAlerta';
    try {
      GlobalHelper.logger.w(jsonEncode(fields));
      GlobalHelper.logger.w(files);
      final response = await interceptorHttp.request(
          context, 'POST', urlEndpoint, null,
          multipartFiles: files, requestType: 'FORM', multipartFields: fields);
      if (!response.error) {
        return GeneralResponse(
            message: response.message, error: response.error);
      }
      return GeneralResponse(message: response.message, error: response.error);
    } catch (error) {
      GlobalHelper.logger.w('Error al Crear Alerta $error');
      return GeneralResponse(message: 'Error al crear Alerta', error: true);
    }
  }
}
