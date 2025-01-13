import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/environment.dart';
import 'package:observa_gye_app/modules/principal_modules/home/model/home_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/models/general_response.dart';
import 'package:observa_gye_app/shared/services/http_interceptor.dart';

class HomeService {
   InterceptorHttp interceptorHttp = InterceptorHttp();
  String url =  Environment().config?.serviceUrl ?? '';

  Future<GeneralResponse<HomeResponse>> getHome(BuildContext context)async{
    final urlService = '$url/home';
    try {
      HomeResponse? homeResponse;

      final response = await interceptorHttp.request(context, 'GET', urlService, null);
      if(!response.error){

        homeResponse = homeResponseFromJson(jsonEncode(response.data));
        return GeneralResponse(message: response.message, error: response.error, data: homeResponse);
      }

      return GeneralResponse(message: response.message, error: response.error);

    } catch (e) {
      GlobalHelper.logger.w('Error al obtener datos: $e');
      return GeneralResponse(message: 'Error al obetener datos', error: true);
    }


  } 



}

