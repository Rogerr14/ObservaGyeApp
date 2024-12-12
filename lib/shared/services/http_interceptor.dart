import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:observa_gye_app/env/environment.dart';
import 'package:observa_gye_app/modules/security/login/login_page.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/models/general_response.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:provider/provider.dart';

class InterceptorHttp {
  Future<GeneralResponse> request(
    BuildContext context,
    String method,
    String endPoint,
    dynamic body, {
    bool showLoading = true,
    Map<String, dynamic>? queryParameters,
    List<http.MultipartFile>? multipartFiles,
    Map<String, String>? multipartFields,
    String requestType = "JSON",
    Function(int sentBytes, int totalBytes)? onProgressLoad,
  }) async {
    final urlService = Environment().config?.serviceUrl ?? "no url";

    String url =
        "$endPoint?${Uri(queryParameters: queryParameters).query}";

    GlobalHelper.logger.t('URL $method: $url');
    body != null
        ? GlobalHelper.logger.log(Level.warning, 'body: ${json.encode(body)}')
        : null;
    queryParameters != null
        ? GlobalHelper.logger.log(
            Level.warning, 'queryParameters: ${json.encode(queryParameters)}')
        : null;

    GeneralResponse generalResponse =
        GeneralResponse(data: null, message: "", error: true);

    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    // final sp = Provider.of<StudentProvider>(context, listen: false);
    // GlobalKey<State<StatefulWidget>> keyLoading = GlobalHelper.genKey();
    final keyLoading = GlobalHelper.genKey();
    // final keyError = GlobalHelper.genKey();

    String? messageButton;
    void Function()? onPress;
    bool closeSession = false;

    try {
      http.Response response;
      Uri uri = Uri.parse(url);

      if (showLoading) {
        GlobalHelper.logger.w("KeyLoading del interceptor: $keyLoading");
        // keyLoading = GlobalHelper.genKey();}
        fp.showAlert(key: keyLoading, content: const AlertLoading());
        // fp.alertLoading = [const SizedBox()];
        // await Future.delayed(const Duration(milliseconds: 600));
      }

      //? Envio de TOKEN
      // AuthResponseModel? userData = await UserDataStorage().getUserData();

      String tokenSesion = '';
      // String tokenSesion = (userData != null) ? userData.token : '';
      // String tokenInformation = "";

      // if (userData != null) {
      //   tokenSesion = userData.token!;
      // }

      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": (requestType == 'JSON') ? tokenSesion : tokenSesion,
        // "versionName": packageInfo.version,
        // "versioncode": packageInfo.buildNumber,
        // "so": Platform.isAndroid ? 'Android' : 'IOS'
      };

      GlobalHelper.logger.w(headers);

      int responseStatusCode = 0;
      String responseBody = "";

      switch (requestType) {
        case "JSON":
          switch (method) {
            case "POST":
              response = await http
                  .post(uri,
                      headers: headers,
                      body: body != null ? json.encode(body) : null)
                  .timeout(const Duration(seconds: 60));
              //inspect(_response);
              break;
            case "GET":
              response = await http.get(uri, headers: headers);
              break;
            case "PUT":
              response = await http.put(uri,
                  headers: headers,
                  body: body != null ? json.encode(body) : null);
              break;
            case "PATCH":
              response = await http.patch(uri,
                  headers: headers,
                  body: body != null ? json.encode(body) : null);
              break;

            default:
              response = await http.post(uri, body: jsonEncode(body));
              break;
          }
          responseStatusCode = response.statusCode;
          responseBody = response.body;
          break; // case JSON

        case "FORM":
          final httpClient = getHttpClient();
          final request = await httpClient.postUrl(Uri.parse(url));

          int byteCount = 0;
          var requestMultipart = http.MultipartRequest(method, Uri.parse(url));
          // print("requesMult");
          if (multipartFiles != null) {
            requestMultipart.files.addAll(multipartFiles);
          }
          if (multipartFields != null) {
            requestMultipart.fields.addAll(multipartFields);
          }

          headers.forEach((key, value) {
            request.headers.set("Authorization", tokenSesion);
          });

          debugPrint("TOKEN CARGADO");

          var msStream = requestMultipart.finalize();

          var totalByteLength = requestMultipart.contentLength;

          request.contentLength = totalByteLength;

          request.headers.set(HttpHeaders.contentTypeHeader,
              requestMultipart.headers[HttpHeaders.contentTypeHeader]!);

          Stream<List<int>> streamUpload = msStream.transform(
            StreamTransformer.fromHandlers(
              handleData: (data, sink) {
                sink.add(data);

                byteCount += data.length;

                if (onProgressLoad != null) {
                  onProgressLoad(byteCount, totalByteLength);
                }
              },
              handleError: (error, stack, sink) {
                generalResponse.error = true;
                throw error;
              },
              handleDone: (sink) {
                sink.close();
                // UPLOAD DONE;
              },
            ),
          );

          await request.addStream(streamUpload);

          final httpResponse = await request.close();
          var statusCode = httpResponse.statusCode;

          responseStatusCode = statusCode;
          if (statusCode ~/ 100 != 2) {
            throw Exception(
                'Error uploading file, Status code: ${httpResponse.statusCode}');
          } else {
            await for (var data in httpResponse.transform(utf8.decoder)) {
              responseBody = data;
            }
          }
          break; // case Form
      }

      GlobalHelper.logger.w('statusCode: ${responseStatusCode.toString()}');

      switch (responseStatusCode) {
        case 200:
          var responseDecoded = json.decode(responseBody);
          //final keySesion = GlobalHelper.genKey();
          if (responseDecoded["datos"] != null) {
          generalResponse.data = responseDecoded["datos"];
            
          }
          generalResponse.error = false;
          generalResponse.message = responseDecoded["mensaje"];
          fp.dismissAlert(key: keyLoading);
          // } else {
          //debugPrint('NO HAY ERROR');
          generalResponse.error = false;
          // generalResponse.message = responseDecoded["mensaje"];
          //fp.dismissAlert(key: keyLoading);
          // }
          break;
        case 307:
          generalResponse.error = true;
          generalResponse.message =
              "Ocurrió un error al consultar con los servicios. Intente con una red que le permita el acceso";
          fp.dismissAlert(key: keyLoading);
          break;
        case 401:
          GlobalHelper.logger.w('entra aqui');
          generalResponse.error = true;
          generalResponse.message =
              'Su sesión ha caducado, vuelva a iniciar sesión.';
          messageButton = 'Volver a ingresar';
          closeSession = true;
          onPress = () async {
            fp.clearAllAlert();
            // fp.setIconAppBarItem(IconItems.iconMenuHome);
            Navigator.pushAndRemoveUntil(
                context,
                GlobalHelper.navigationFadeIn(context, const LoginPage()),
                (route) => false);
            // UserDataStorage().removeDataLogin();
            // UserDataStorage().removeSelected();
            // sp.setPositionStudent(0);
          };
          fp.dismissAlert(key: keyLoading);
          break;
        case 512:
          generalResponse.error = true;
          generalResponse.message =
              'Tiempo de espera agotado. El servidor no pudo procesar tu solicitud a tiempo. Inténtalo de nuevo más tarde.';
          fp.dismissAlert(key: keyLoading);
          break;
        default:
          generalResponse.error = true;
          generalResponse.message = json.decode(responseBody)["mensaje"];
          GlobalHelper.logger.w(generalResponse.message);
          fp.dismissAlert(key: keyLoading);
          break;
      }
    } on TimeoutException catch (e) {
      GlobalHelper.logger.e("Error en TimeoutException: $e");
      //debugPrint('$e');
      generalResponse.error = true;
      generalResponse.message = 'Tiempo de conexión excedido.';
      fp.dismissAlert(key: keyLoading);
    } on FormatException catch (ex) {
      generalResponse.error = true;
      generalResponse.message = ex.toString();
      //debugPrint(ex.toString());
      GlobalHelper.logger.e("Error en FormatException: $ex");
      fp.dismissAlert(key: keyLoading);
    } on SocketException catch (exSock) {
      GlobalHelper.logger.e("Error por conexion: $exSock");
      //debugPrint("Error por conexion -> ${exSock.toString()}");
      generalResponse.error = true;
      // generalResponse.message = exSock.toString();
      generalResponse.message =
          "Verifique su conexión a internet y vuelva a intentar.";
      fp.dismissAlert(key: keyLoading);
    } on Exception catch (e, stacktrace) {
      GlobalHelper.logger.e("Error en request: $stacktrace");
      //debugPrint("Error en request -> ${stacktrace.toString()}");
      generalResponse.error = true;
      generalResponse.message = "Ocurrio un error, vuelva a intentarlo.";
      fp.dismissAlert(key: keyLoading);
    }

    if (!generalResponse.error) {
      if (showLoading) {
        fp.dismissAlert(key: keyLoading);
        //fp.alertLoading = [];
      }
    } else {
      //debugPrint("Key de error del Interceptor: $keyError");
      final keyError = GlobalHelper.genKey();

      fp.showAlert(
        key: keyError,
        content: AlertGeneric(
          content: ErrorGeneric(
            closeSession: closeSession,
            keyToClose: keyError,
            message: generalResponse.message,
            messageButton: messageButton,
            onPress: onPress,
          ),
        ),
      );
    }

    return generalResponse;
  }

  HttpClient getHttpClient() {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 6)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = Completer<String>();
    var contents = StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
      // print(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}
