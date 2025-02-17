import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_alert/model/type_alerts_model.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_observation/model/observation_model_body.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_observation/services/select_especie_data.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_observation/widget/especy_widget.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_observation/widget/select_especie.dart';
import 'package:observa_gye_app/modules/principal_modules/main_page/page/main_page.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/especies_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/services/alerts_services.dart';
import 'package:observa_gye_app/shared/services/observtion_services.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/date_time_picker_widget.dart';
import 'package:observa_gye_app/shared/widget/drop_down_button_widget.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/gps_ubication_widget.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class GenerateObservationPage extends StatefulWidget {
  final XFile image;
  const GenerateObservationPage({super.key, required this.image});

  @override
  State<GenerateObservationPage> createState() =>
      _GenerateObservationPageState();
}

class _GenerateObservationPageState extends State<GenerateObservationPage> {
  late FunctionalProvider fp;
  final _keyStateAlert = GlobalKey<FormState>();
  TextEditingController _controllerdateTime = TextEditingController();
  TextEditingController _gpsController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;

  String selectSendero = '';
  double latitud = 0.0;
  double longitud = 0.0;

  List<File> imagenes = [];
  List<DropdownMenuItem<String>> senderos = [];

  ImagePicker imagePicker = ImagePicker();
  Especy? especie;
  TypeAlertsModel? typeAlertsModel;

  SelectEspecyForm selectEspecie = SelectEspecyForm();

  Set<Marker> marker = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _getSenderos();
        // _getEspecies();
        final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
        _controllerdateTime.text = formattedDate;
      },
    );
    fp = Provider.of<FunctionalProvider>(context, listen: false);
    imagenes.add(File(widget.image.path));
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  void _generateObservation() async {
    especie = especie;
    ObservationModelBody observation = ObservationModelBody(
        idEspecie: especie?.idEspecie,
        idSendero: int.parse(selectSendero),
        descripcion: _noteController.text,
        nombreTemporal: especie?.nombreTemporal,
        fechaObservacion: DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
        ),
        coordenadaLongitud: longitud,
        coordenadaLatitud: latitud,
        estado: false);
    GlobalHelper.logger.w(jsonEncode(observation));
    final List<MultipartFile> imagenesSend = await Future.wait(imagenes.map(
      (imagen) async {
        return await MultipartFile.fromPath('imagenes', imagen.path,
            contentType: MediaType('image', 'jpg'));
      },
    ).toList());

    final response = await ObservationServices().sendObservationReport(
        context, imagenesSend, {"observacion": jsonEncode(observation)});
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

              if (fp.alerts.isEmpty) {
                Navigator.pushAndRemoveUntil(
                    context,
                    GlobalHelper.navigationFadeIn(context, MainPage()),
                    (route) => false);
              }
              setState(() {});
            },
          )));
    }
  }

  void _getSenderos() async {
    final response = await AlertsServices().getTypeAlerts(
      context,
    );
    if (!response.error) {
      typeAlertsModel = response.data;
      if (typeAlertsModel != null) {
        // selectAlert = typeAlertsModel!.tiposAlertas.first.tipoAlerta;

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
    setState(() {});
  }

  _takePick(Responsive responsive) async {
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
                        }
                        setState(() {});
                      },
                      icon: Column(
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
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Form(
      key: _keyStateAlert,
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
                    title: 'Agregar Observación',
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextTitleWidget(
                      title: 'Nombre Especie',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          final keyEspeciesSelect = GlobalHelper.genKey();
                          fp.showAlert(
                              key: keyEspeciesSelect,
                              content: AlertGeneric(
                                content: SelectEspecie(
                                  keyDismiss: keyEspeciesSelect,
                                  onPress: (especy) {
                                    especie = especy;
                                    setState(() {});
                                  },
                                ),
                              ),
                              closeAlert: true);
                          setState(() {});
                        },
                        child: EspecyWidget(
                          especies: especie,
                          titleAlt: 'Seleccione una especie',
                        )),
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
                      title: 'Fecha observación',
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
                                setState(() {
                                  _gpsController.text =
                                      '${latLong.latitude}, ${latLong.longitude}';
                                  latitud = latLong.latitude;
                                  longitud = latLong.longitude;

                                  // Actualizar el marcador en la pantalla principal
                                  marker = {
                                    Marker(
                                      markerId: MarkerId('Observacion'),
                                      position: latLong,
                                    ),
                                  };
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
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
                                      width: responsive.wp(15),
                                      fit: BoxFit.cover,
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
                                      icon: Icon(
                                        Icons.highlight_remove,
                                        color: AppTheme.error,
                                      ))),
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
                      controller: _noteController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: FilledButtonWidget(
                          onPressed: () {
                            if (_keyStateAlert.currentState!.validate()) {
                              if (imagenes.isEmpty || especie == null) {
                                final keyNoPhoroAlert = GlobalHelper.genKey();
                                fp.showAlert(
                                  key: keyNoPhoroAlert,
                                  content: AlertGeneric(
                                    content: NoExistInformation(
                                      message: (imagenes.isEmpty)
                                          ? 'Debe enviar al menos una imagen.'
                                          : 'Seleccone una especie, por favor.',
                                      function: () {
                                        fp.dismissAlert(key: keyNoPhoroAlert);
                                      },
                                    ),
                                    keyToClose: keyNoPhoroAlert,
                                  ),
                                );
                              } else {
                                _generateObservation();
                              }
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
    );
  }
}
