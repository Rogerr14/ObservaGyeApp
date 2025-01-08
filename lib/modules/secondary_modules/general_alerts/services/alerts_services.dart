import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/environment.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/model/type_alerts_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/models/general_response.dart';
import 'package:observa_gye_app/shared/services/http_interceptor.dart';

class AlertsServices {
  InterceptorHttp interceptorHttp = InterceptorHttp();
  final urlService = Environment().config?.serviceUrl ?? '';

  Future<GeneralResponse<TypeAlertsModel>> getTypeAlerts(
      BuildContext context) async {
    final url = '$urlService/Alerta/tipo_alertas';
    try {
      late TypeAlertsModel typeAlertsModel;
      final response = await interceptorHttp.request(context, 'GET', url, null);
      if (!response.error) {
        typeAlertsModel = typeAlertsModelFromJson(jsonEncode(response.data));
        return GeneralResponse(
            message: response.message,
            error: response.error,
            data: typeAlertsModel);
      }
      return GeneralResponse(message: response.message, error: response.error);
    } catch (e) {
      GlobalHelper.logger.e('Error al obtener tipo de alertas $e');
      return GeneralResponse(message: e.toString(), error: true);
    }
  }
}
