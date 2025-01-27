import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_observation/widget/especy_widget.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/especies_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/services/observtion_services.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/text_button_widget.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class SelectEspecie extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> keyDismiss;
  final Function(Especy) onPress;
  SelectEspecie({
    super.key,
    required this.keyDismiss,
    required this.onPress,
  });

  @override
  State<SelectEspecie> createState() => _SelectEspecieState();
}

class _SelectEspecieState extends State<SelectEspecie> {
  TextEditingController _especie = TextEditingController();

  ListEspecies? listEspecies;
  List<Especy> especies = [];
  bool cargando = false;

  void _getEspecies() async {
    if (!cargando) {
      GlobalHelper.logger.i('Hace peticion');
      cargando = true;
      final body = {
        "especie": _especie.text,
      };
      final response = await ObservationServices().getEspecies(context, body);
      if (!response.error) {
        listEspecies = response.data;
        especies = listEspecies!.especies;
      }

        cargando = false;
    }

    setState(() {});
  }

  @override
  void initState() {
    _especie.addListener(_getEspecies);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _especie.removeListener(_getEspecies);
    // TODO: implement initState
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return SizedBox(
      height: responsive.height *0.7,
      child: Container(
        decoration: BoxDecoration(
            color: AppTheme.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: responsive.height *0.63,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextTitleWidget(title: 'Selección de especie'),
              SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                // maxWidth: responsive.
                // width*0.6,
                // maxLength: 27,
                controller: _especie,
                hintText: 'Busca o sugiere una especie',
                
                onChanged: (value) {
                  if (value.trim().isNotEmpty && value.trim().length >= 3) {
                    GlobalHelper.logger.f('Entra al metodo');
                    _getEspecies();
                  } else {
                    especies.clear();
                  }
                  setState(() {
                    // GlobalHelper.logger.w('redibuja');
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              
              
              
              Visibility(
                visible: 
              _especie.text.trim().isNotEmpty ,
                child: especies.isNotEmpty
                    ? Expanded(
                      child: SingleChildScrollView(
                        
                        child: Column(
                            children: especies
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: InkWell(
                                        onTap: () {
                                          final especieSeleccionada = Especy(
                                              idEspecie: e.idEspecie,
                                              nombreComun: e.nombreComun,
                                              nombreCientifico: e.nombreCientifico,
                                              nombreCategoria: e.nombreCategoria,
                                              imagen: e.imagen);
                                    
                                          widget.onPress(especieSeleccionada);
                                          final fp = Provider.of<FunctionalProvider>(
                                              context,
                                              listen: false);
                                          fp.dismissAlert(key: widget.keyDismiss);
                                          GlobalHelper.logger.w('hola');
                                          setState(() {});
                                        },
                                        child: EspecyWidget(
                                          especies: e,
                                        )),
                                  ),
                                )
                                .toList(),
                          ),
                      ),
                    )
                    : Column(
                      children: [
                        InkWell(
                            onTap: (_especie.text.trim().isEmpty)
                                ? null
                                : () {
                                    final especieSeleccionada =
                                        Especy(nombreTemporal: _especie.text);
                                  
                                    widget.onPress(especieSeleccionada);
                                    final fp = Provider.of<FunctionalProvider>(context,
                                        listen: false);
                                    fp.dismissAlert(key: widget.keyDismiss);
                                    GlobalHelper.logger.w('hola');
                                    setState(() {});
                                  },
                            child: EspecyWidget(
                              titleAlt: (
                                  _especie.text),
                            )),
                      ],
                    ),
              ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButtonWidget(text: 'Cancelar', onPressed: (){
              final fp = Provider.of<FunctionalProvider>(context, listen: false);
              fp.dismissAlert(key: widget.keyDismiss);
            },)
          ],
        ),
      ),
    );
  }
}
