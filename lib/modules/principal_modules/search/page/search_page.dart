import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/widget/list_widget.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/observations_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/services/observtion_services.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchEspecie = TextEditingController();
  Observations? observations;
  late FunctionalProvider fp;
  @override
  void initState() {
    
    fp = Provider.of<FunctionalProvider>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _searchObservations() async {
    
    final body = {"especie": searchEspecie.text.trim().toLowerCase()};
    final response =
        await ObservationServices().searchObservations(context, body);
    if (!response.error) {
      if (response.data!.observaciones.isNotEmpty) {
        observations = response.data;
        setState(() {});
      } else {
        final keyAlertsEmpity = GlobalHelper.genKey();
        fp.showAlert(
          key: keyAlertsEmpity,
          content: AlertGeneric(
            content: NoExistInformation(
              message: 'No existen observaciones',
              function: () {
                fp.dismissAlert(key: keyAlertsEmpity);
              },
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Column(
      children: [
        TextTitleWidget(title: 'Buscar Especies'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: TextFormFieldWidget(
            onChanged: (val){
              setState(() {
                
              });
            },
            controller: searchEspecie,
            hintText: 'Buscar nombre de especies',
            inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                    ],
            suffixIcon: searchEspecie.text.trim().isNotEmpty ?
            IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
                color: AppTheme.primaryColor,
              ),
              
              onPressed: () {
                if (searchEspecie.text.trim().isNotEmpty) {
                  _searchObservations();
                }
              },
            ):  SizedBox(),
          ),
        ),
    
        if(observations != null)
              Expanded(
                child: ListView.builder(
                   itemCount: observations!.observaciones.length,
                  itemBuilder: (context, index) => ListWidgetObservations(observations: observations!.observaciones[index],),),
              ),
      ],
    );
  }
}
