import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:observa_gye_app/env/environment.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/especies_model.dart';
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
      GlobalHelper.logger.w(jsonEncode(fields));
      GlobalHelper.logger.w(files);
      final response = await interceptorHttp.request(
          context, 'POST', urlEndpoint, null,
          multipartFiles: files, multipartFields: fields, requestType: 'FORM');

      if (!response.error) {
        return GeneralResponse(
            message: response.message, error: response.error);
      }
      return GeneralResponse(message: response.message, error: response.error);
    } catch (error) {
      GlobalHelper.logger.w('Error al Crear Observacion $error');
      return GeneralResponse(
          message: 'Error al crear Observación', error: true);
    }
  }

  Future<GeneralResponse<Observations>> getObservations(BuildContext context,
      {String user_id = '', int? estado}) async {
    final urlEndpoint = '$urlService/Observacion/ListaObservaciones';
    try {
      GlobalHelper.logger.w('Entra aqui , $estado');
      // final estado_alerta = estado != null ? 
      //   estado.toString()
      //  : "";
      final query =  estado != null ?  {"estado": estado.toString(), "id_usuario": user_id} : {"id_usuario": user_id};
      final response = await interceptorHttp.request(
          context, 'GET', urlEndpoint, null,
          queryParameters:query);
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

  Future<GeneralResponse<ListEspecies>> getEspecies(
      BuildContext context, dynamic body) async {
    String urlEndpoint = '$urlService/Especie/searchEspecies';
    try {
      ListEspecies? listEspecies;

      final response =
          await interceptorHttp.request(context, 'POST', urlEndpoint, body, showLoading: false);
      if (!response.error) {
        listEspecies = listEspeciesFromJson(jsonEncode(response.data));
        return GeneralResponse(
            message: response.message,
            error: response.error,
            data: listEspecies);
      }
      return GeneralResponse(message: response.message, error: response.error);
    } catch (e) {
      GlobalHelper.logger.e('Error al obtener Especies $e');
      return GeneralResponse(
          message: 'Error al obtener especies $e', error: true);
    }
  }

  Future<GeneralResponse<Observations>> searchObservations(
      BuildContext context, dynamic body) async {
    final urlEndpoint = '$urlService/Observacion/buscarObservacion';

    try {
      Observations? observation;
      final response =
          await interceptorHttp.request(context, 'POST', urlEndpoint, body);
      if (!response.error) {
        observation = observationsFromJson(jsonEncode(response.data));
        return GeneralResponse(
            message: response.message,
            error: response.error,
            data: observation);
      }
      return GeneralResponse(message: response.message, error: response.error);
    } catch (e) {
      GlobalHelper.logger.e('Error al buscar observaciones $e');
      return GeneralResponse(
          message: 'Error al buscar observaciones $e', error: true);
    }
  }
}
