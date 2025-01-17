import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:observa_gye_app/env/environment.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_alert/model/type_alerts_model.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/model/alerts_model.dart';
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



  Future<GeneralResponse<AlertsModel>> getAlerts(BuildContext context,{String id_user = '', String id_estado = ''}) async{
    final urlEndpoint = '$urlService/Alerta/ListaAlertas';
    try {
      final response = await interceptorHttp.request(context, 'GET', urlEndpoint, null, queryParameters: {
        "id_usuario" : id_user,
        "id_estado": id_estado
      } );
      late AlertsModel listAlerts;
      if(!response.error){
        listAlerts = alertsModelFromJson(jsonEncode(response.data));
        return GeneralResponse(message: response.message, error: response.error, data: listAlerts);
      }
      return GeneralResponse(message: response.message, error: response.error);
    } catch (e) {
      GlobalHelper.logger.w('Error al obtener alertas $e');
      return GeneralResponse(message: 'Error al obtener alertas', error: true);
    }
  }
}
