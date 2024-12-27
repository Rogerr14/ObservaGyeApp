import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/date_time_picker_widget.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class GenerateObservationPage extends StatefulWidget {
  const GenerateObservationPage({super.key});

  @override
  State<GenerateObservationPage> createState() =>
      _GenerateObservationPageState();
}

class _GenerateObservationPageState extends State<GenerateObservationPage> {
  TextEditingController _controllerdateTime = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;

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
              children: [
                const TextFormFieldWidget(
                  hintText: 'Nombre de la especie',
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
