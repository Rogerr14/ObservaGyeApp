import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_alert/model/alert_data.dart';
import 'package:observa_gye_app/modules/principal_modules/home/page/home_page.dart';
import 'package:observa_gye_app/modules/principal_modules/main_page/page/main_page.dart';
import 'package:observa_gye_app/shared/services/alerts_services.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_alert/model/type_alerts_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/date_time_picker_widget.dart';
import 'package:observa_gye_app/shared/widget/drop_down_button_widget.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/gps_ubication_widget.dart';
import 'package:observa_gye_app/shared/widget/layout.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class GenerateAlertage extends StatefulWidget {
  final XFile image;
  // final GlobalKey<State<StatefulWidget>> keyDismiss;
  const GenerateAlertage({
    super.key,
    required this.image,
  });

  @override
  State<GenerateAlertage> createState() => _GenerateAlertageState();
}

class _GenerateAlertageState extends State<GenerateAlertage> {
  // XFile? image;
  final _keyStateAlert = GlobalKey<FormState>();
  late FunctionalProvider fp;
  ImagePicker imagePicker = ImagePicker();
  TypeAlertsModel? typeAlertsModel;
  Set<Marker> marker = {};

  final TextEditingController _controllerdateTime = TextEditingController();
  final TextEditingController _descriptionAlert = TextEditingController();
  final TextEditingController _gpsController = TextEditingController();

  String selectAlert = '';
  String selectSendero = '';
  double latitud = 0.0;
  double longitud = 0.0;

  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;

  List<File> imagenes = [];
  List<DropdownMenuItem<String>> alertType = [];
  List<DropdownMenuItem<String>> senderos = [];

  @override
  void initState() {
    fp = Provider.of<FunctionalProvider>(context, listen: false);
    // _takePick();
    imagenes.add(File(widget.image.path));
    // _compressImage(widget.image);
    _readMetaData();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _getTypesAlerts();
      },
    );
    super.initState();
  }

  _generateAlert() async {
    AlertData alerta = AlertData(
        idTipoAlerta: int.parse(selectAlert),
        idSendero: int.parse(selectSendero),
        coordenadaLongitud: longitud,
        coordenadaLatitud: latitud,
        descripcion: _descriptionAlert.text,
        fechaCreado: DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
        ));
    GlobalHelper.logger.i(jsonEncode(alerta));
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final List<MultipartFile> imagenesSend = await Future.wait(imagenes.map(
      (imagen) async {
        return await MultipartFile.fromPath('imagenes', imagen.path,
            contentType: MediaType('image', 'jpg'));
      },
    ).toList());
    final response = await AlertsServices()
        .sendAlertReport(context, imagenesSend, {"alerta": jsonEncode(alerta)});
    if (!response.error) {
      final keyOkAlert = GlobalHelper.genKey();
      fp.showAlert(
          key: keyOkAlert,
          content: AlertGeneric(
              content: OkGeneric(
            message: response.message,
            keyToClose: keyOkAlert,
            onPress: () {
              fp.dismissAlert(key: keyOkAlert);
              fp.setIconBottomNavigationBarItem(
                  ButtonNavigatorBarItem.iconMenuHome);
                  if(fp.alerts.isEmpty){
                    
                    Navigator.pushAndRemoveUntil(context, GlobalHelper.navigationFadeIn(context, MainPage()), (route) => false);

                  }
              setState(() {});
            },
          )));
    }
  }

  // _compressImage(XFile file) async {
  //   final fileCompress = await FlutterImageCompress.compressWithFile(file.path);
  //   if (fileCompress != null) {
  //     final fileImage = File;
  //     GlobalHelper.logger.w(fileImage.path);
  //   }
  // }

  _getTypesAlerts() async {
    final response = await AlertsServices().getTypeAlerts(context);
    if (!response.error) {
      typeAlertsModel = response.data;
      if (typeAlertsModel != null) {
        // selectAlert = typeAlertsModel!.tiposAlertas.first.tipoAlerta;
        alertType = typeAlertsModel!.tiposAlertas
            .map(
              (alerta) => DropdownMenuItem(
                  value: alerta.idTipoAlerta,
                  child: TextSubtitleWidget(subtitle: alerta.tipoAlerta)),
            )
            .toList();
        senderos = typeAlertsModel!.senderos
            .map(
              (sendero) => DropdownMenuItem(
                  value: sendero.idSendero,
                  child: TextSubtitleWidget(
                    subtitle: sendero.nombreSendero,
                  )),
            )
            .toList();
      }
    }
    GlobalHelper.logger.w('alertas ${alertType.length}');
    setState(() {});
  }

  _readMetaData() async {
    final fileBytes = File(widget.image.path).readAsBytesSync();
    final data = await readExifFromBytes(fileBytes);
    if (data.isEmpty) {
      GlobalHelper.logger.w('no existe la data');
    } else {
      GlobalHelper.logger.i(data);
    }
  }

  _takePick(Responsive responsive) async {
    // image = await picker.pickImage(source: ImageSource.camera);
    final selectSourcekey = GlobalHelper.genKey();
    fp.showAlert(
        key: selectSourcekey,
        content: AlertGeneric(
          content: Container(
            child: Column(
              children: [
                TextTitleWidget(title: 'Selecciona una opción'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        final photo = await imagePicker.pickImage(
                            source: ImageSource.camera);
                        if (photo != null) {
                          fp.dismissAlert(key: selectSourcekey);
                          imagenes.add(File(photo.path));
                          // _compressImage(photo);
                        }
                        setState(() {});
                      },
                      icon: const Column(
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 24,
                            color: AppTheme.primaryColor,
                          ),
                          TextTitleWidget(title: 'Cámara')
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: () async {
                        fp.dismissAlert(key: selectSourcekey);

                        final photo = await imagePicker.pickImage(
                            source: ImageSource.gallery);

                        if (photo != null) {
                          imagenes.add(File(photo.path));
                        }
                        setState(() {});
                      },
                      icon: const Column(
                        children: [
                          Icon(
                            Icons.photo,
                            size: 24,
                            color: AppTheme.primaryColor,
                          ),
                          TextTitleWidget(title: 'Galeria')
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          dismissable: true,
          keyToClose: selectSourcekey,
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Form(
      key: _keyStateAlert,
      child: SizedBox(
        height: responsive.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextTitleWidget(
                      title: 'Agregar Alerta',
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextTitleWidget(
                        title: 'Tipo de Alerta',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropDownButtonWidget(
                        hint: 'Seleccione la alerta...',
                        validator: (value) {
                          if (value == null) {
                            return 'Seleccione una opcion';
                          }
                          return null;
                        },
                        items: alertType,
                        onChanged: (value) {
                          selectAlert = value!;
                          GlobalHelper.logger.w(value);
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextTitleWidget(
                        title: 'Sendero',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropDownButtonWidget(
                        hint: 'Seleccione un sendero...',
                        validator: (value) {
                          if (value == null) {
                            return 'Seleccione una opcion';
                          }
                          return null;
                        },
                        items: senderos,
                        onChanged: (value) {
                          selectSendero = value!;
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextTitleWidget(
                        title: 'Fecha de alerta',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DateTimePickerWidget(
                        controller: _controllerdateTime,
                        onTap: () {
                          final keyCalendar = GlobalHelper.genKey();
                          final fp = Provider.of<FunctionalProvider>(context,
                              listen: false);
                          final formattedDate =
                                    DateFormat('dd/MM/yyyy').format(selectedDate);
                                _controllerdateTime.text = formattedDate;
                          fp.showAlert(
                            key: keyCalendar,
                            content: AlertGeneric(
                                content: CustomDatePickerAlert(
                              keyToClose: keyCalendar,
                              initialDate: selectedDate,
                              lastDate: DateTime.now(),
                              onDateSelected: (date) {
                                selectedDate = date;
                                final formattedDate =
                                    DateFormat('dd/MM/yyyy').format(date);
                                _controllerdateTime.text = formattedDate;
                                setState(() {});
                              },
                            )),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextTitleWidget(
                        title: 'Ubicación Geográfica',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GpsUbicationWidget(
                          controller: _gpsController,
                          onTap: () {
                            final keyMapAlert = GlobalHelper.genKey();
                            fp.showAlert(
                              key: keyMapAlert,
                              content: AlertGeneric(
                                content: GpsSelectUbication(
                                  keyDismiss: keyMapAlert,
                                  markers: marker,
                                  selectPosition: (latLong) {
                                    _gpsController.text =
                                        '${latLong.latitude}, ${latLong.latitude}';
                                    latitud = latLong.latitude;
                                    longitud = latLong.latitude;
                                    setState(() {});
                                  },
                                ),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextTitleWidget(
                        title: 'Foto de Alerta',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          ...imagenes.map(
                            (e) => Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      e,
                                      height: responsive.hp(10),
                                      // width: responsive.wp(2),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -20,
                                  right: -10,
                                  child: IconButton(
                                    onPressed: () {
                                      imagenes.removeWhere(
                                        (element) => element == e,
                                      );
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.highlight_remove_rounded,
                                      color: AppTheme.error,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          (imagenes.length != 3)
                              ? InkWell(
                                  onTap: () {
                                    _takePick(responsive);
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(10),
                                    // padding: EdgeInsets.all(6),
                                    child: SizedBox(
                                      height: responsive.hp(10),
                                      width: responsive.wp(15),
                                      child: Center(
                                        child: Icon(
                                          Icons.add_a_photo,
                                          color: AppTheme.primaryColor,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextTitleWidget(
                        title: 'Notas Adicionales',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormFieldWidget(
                        hintText: 'Agregar una nota...',
                        maxLines: 4,
                        controller: _descriptionAlert,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: FilledButtonWidget(
                            onPressed: () {
                              if(_keyStateAlert.currentState!.validate()){
                                 if (imagenes.isEmpty ) {
                                final keyNoPhoroAlert = GlobalHelper.genKey();
                                fp.showAlert(
                                  key: keyNoPhoroAlert,
                                  content: AlertGeneric(
                                    content: NoExistInformation(
                                      message: (imagenes.isEmpty)
                                          ? 'Debe enviar al menos una imagen'
                                          : 'Seleccone una especie, por favor.',
                                      function: () {
                                        fp.dismissAlert(key: keyNoPhoroAlert);
                                      },
                                    ),
                                    keyToClose: keyNoPhoroAlert,
                                  ),
                                );
                              } else {

                              _generateAlert();}
                              }
                            },
                            text: 'Enviar',
                            height: responsive.hp(5),
                            width: responsive.wp(35),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
