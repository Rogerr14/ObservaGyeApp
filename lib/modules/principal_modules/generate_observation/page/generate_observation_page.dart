import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/date_time_picker_widget.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
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
  TextEditingController _controllerdateTime = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  List<File> imagenes = [];
  ImagePicker imagePicker = ImagePicker();

  late FunctionalProvider fp;


  @override
  void initState() {
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




  _readMetaData() async {
    final fileBytes =  File(widget.image.path).readAsBytesSync();
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
    return Padding(
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
                const TextFormFieldWidget(
                  hintText: 'Nombre de la especie',
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
                    final fp =
                        Provider.of<FunctionalProvider>(context, listen: false);

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
                const TextFormFieldWidget(
                  hintText: 'Ubicación',
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
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              top: 0,
                              right: 0,
                              child: IconButton(
                                  onPressed: () {
                                    imagenes.removeWhere(
                                      (element) => element == e,
                                    );
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.highlight_remove_rounded))),
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
                const SizedBox(height: 20,),
                const TextTitleWidget(
                  title: 'Notas Adicionales',
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextFormFieldWidget(
                  hintText: 'Agregar una nota...',
                  maxLines: 4,
                ),
                 const SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.center,
                    child: FilledButtonWidget(
                      onPressed: () {},
                      text: 'Enviar',
                      height: responsive.hp(5),
                      width: responsive.wp(35),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
