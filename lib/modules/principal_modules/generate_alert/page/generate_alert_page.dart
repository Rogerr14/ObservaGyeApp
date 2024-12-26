import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/date_time_picker_widget.dart';
import 'package:observa_gye_app/shared/widget/drop_down_button_widget.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class GenerateAlertage extends StatefulWidget {
  // final GlobalKey<State<StatefulWidget>> keyDismiss;
  const GenerateAlertage({
    super.key,
  });

  @override
  State<GenerateAlertage> createState() => _GenerateAlertageState();
}

class _GenerateAlertageState extends State<GenerateAlertage> {
  XFile? image;
  final ImagePicker picker = ImagePicker();
  String selectAlert = '';
   DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  TextEditingController _controllerdateTime = TextEditingController();

  List<DropdownMenuItem<String>> alertType = [
    const DropdownMenuItem(
      value: '1',
      child: TextSubtitleWidget(subtitle: 'Fuego'),
    ),
    const DropdownMenuItem(
      value: '2',
      child: TextSubtitleWidget(subtitle: 'Deforestación'),
    ),
  ];

  @override
  void initState() {
    // _takePick();
    super.initState();
  }

  // _takePick() async {
  //   // image = await picker.pickImage(source: ImageSource.camera);
  //   await picker.pickMultiImage()
  // }

  @override
  Widget build(BuildContext context) {
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
                title: 'Agregar Alerta',
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
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
                    setState(() {
                      
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
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
                const TextFormFieldWidget(
                  hintText: 'Ubicación',
                  suffixIcon: Icon(Icons.public_rounded, size: 24, color: AppTheme.primaryColor,),
                ),
                const SizedBox(
                  height: 20,
                ),
                 const TextFormFieldWidget(
                  hintText: 'Agregar una nota...',
                  maxLines: 4,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
