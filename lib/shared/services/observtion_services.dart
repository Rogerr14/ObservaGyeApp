import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:observa_gye_app/env/environment.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/observations_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/models/general_response.dart';
import 'package:observa_gye_app/shared/services/http_interceptor.dart';

class ObservationServices {
  InterceptorHttp interceptorHttp = InterceptorHttp();
  final urlService = Environment().config?.serviceUrl ?? '';

  Future<GeneralResponse> sendObservationReport(BuildContext context,
      List<MultipartFile> files, Map<String, String> fields) async {
        final urlEndpoint = '$urlService/Observacion/CrearObservacion';
        try {
          final response = await interceptorHttp.request(context, 'POST', urlEndpoint, null, multipartFiles: files, multipartFields: fields, requestType: "FORM");

         if (!response.error) {
        return GeneralResponse(
            message: response.message, error: response.error);
      }
      return GeneralResponse(message: response.message, error: response.error);
    } catch (error) {
      GlobalHelper.logger.w('Error al Crear Observacion $error');
       return GeneralResponse(message: 'Error al crear Observación', error: true);
    }

  }

  Future<GeneralResponse<Observations>> getObservations(BuildContext context,
      {String user_id = ''}) async {
    final urlEndpoint = '$urlService/Observacion/ListaObservaciones';
    try {
      final response = await interceptorHttp.request(
          context, 'GET', urlEndpoint, null,
          queryParameters: {"estado": "true", "id_usuario": user_id});
      late Observations observations;
      if (!response.error) {
        observations = observationsFromJson(jsonEncode(response.data));
        return GeneralResponse(
            message: response.message,
            error: response.error,
            data: observations);
      }
      return GeneralResponse(message: response.message, error: response.error);
    } catch (e) {
      GlobalHelper.logger.w('Error al obtener observaciones $e');
      return GeneralResponse(
          message: 'Error al obtener observaciones', error: true);
    }
  }
}
