import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_observation/widget/especy_widget.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/especies_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/services/observtion_services.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class SelectEspecie extends StatefulWidget {
  
  final GlobalKey<State<StatefulWidget>> keyDismiss;
  SelectEspecie({super.key, required this.keyDismiss});

  @override
  State<SelectEspecie> createState() => _SelectEspecieState();
}

class _SelectEspecieState extends State<SelectEspecie> {
  TextEditingController _especie = TextEditingController();

  ListEspecies? listEspecies;
  List<Especy> especies = [];

  void _getEspecies() async {
    final body = {
      "especie": _especie.text,
    };
    final response = await ObservationServices().getEspecies(context, body);
    if (!response.error) {
      listEspecies = response.data;
      especies = listEspecies!.especies;
  
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Container(
      height: responsive.height *0.5,
      decoration: BoxDecoration(
          color: AppTheme.white, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextTitleWidget(title: 'Especies'),
            TextFormFieldWidget(
              controller: _especie,
              hintText: 'Buscar Especies',
              onFieldSubmitted: (value) {
                if (value.trim().isNotEmpty && value.trim().length >= 3) {
                  _getEspecies();
                } else {
                  especies.clear();
                }
                setState(() {
                  GlobalHelper.logger.w('redibuja');
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            especies.isNotEmpty
                ? Column(
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
                                      
                                      final fp = Provider.of<FunctionalProvider>(context,listen: false);
                                      fp.dismissAlert(key: widget.keyDismiss );
                                      fp.setEspecie(especieSeleccionada);
                                      setState(() {
                                        
                                      });
                                },
                                child: EspecyWidget(
                                  especies: e,
                                )),
                          ),
                        )
                        .toList(),
                  )
                : EspecyWidget(titleAlt: (_especie.text.trim().isEmpty ? 'Seleccione una especie': _especie.text),)
          ],
        ),
      ),
    );
  }
}
