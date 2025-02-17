import 'package:flutter/material.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class TermsAndConditionsWidget extends StatefulWidget {
  final GlobalKey keyDismiss;
  const TermsAndConditionsWidget({super.key, required this.keyDismiss});

  @override
  State<TermsAndConditionsWidget> createState() =>
      _TermsAndConditionsWidgetState();
}

class _TermsAndConditionsWidgetState extends State<TermsAndConditionsWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.7,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.center,
                child: TextTitleWidget(title: 'Términos y Condiciones')),
            TextTitleWidget(title: 'Tratado de Datos'),
            TextSubtitleWidget(
                subtitle:
                    'La aplicación OOBSERVAGYE se compromete a proteger la privacidad y seguridad de los datos de los usuarios. A continuación, se establecen las condiciones bajo las cuales se recopilarán, procesarán y almacenarán los datos.'),
            SizedBox(
              height: 5,
            ),
            TextTitleWidget(title: 'Tipos de datos recopilados'),
            TextSubtitleWidget(
                subtitle:
                    'Información de registro: nombre, correo electrónico, contraseña y ubicación geográfica.'),
            TextSubtitleWidget(
                subtitle:
                    'Datos de observaciones: imágenes, videos, texto y coordenadas geográficas de las observaciones realizadas por los usuarios.'),
            TextSubtitleWidget(
                subtitle:
                    'Datos de alertas: texto y coordenadas geográficas de las alertas reportadas por los usuarios.'),
            SizedBox(
              height: 5,
            ),
            TextTitleWidget(title: 'Propósito de la recopilación de datos'),
            TextSubtitleWidget(
                subtitle: 'Los datos recopilados se utilizarán para:'),
            TextSubtitleWidget(
                subtitle:
                    'Mejorar la experiencia del usuario en la aplicación.'),
            TextSubtitleWidget(
                subtitle:
                    'Analizar y visualizar los patrones y tendencias en las observaciones y alertas reportadas.'),
            TextSubtitleWidget(
                subtitle:
                    'Proporcionar información valiosa a los investigadores, científicos y tomadores de decisiones para la conservación y el manejo sostenible de los ecosistemas.'),
            SizedBox(
              height: 5,
            ),
            TextTitleWidget(title: 'Seguridad y protección de los datos'),
            TextSubtitleWidget(
                subtitle:
                    'La aplicación implementará medidas de seguridad adecuadas para proteger los datos de los usuarios, incluyendo:'),
            TextSubtitleWidget(
                subtitle: 'Autenticación y autorización de los usuarios.'),
            TextSubtitleWidget(
                subtitle: 'Actualizaciones y parches de seguridad regulares.'),
            SizedBox(
              height: 5,
            ),
            TextTitleWidget(title: 'Derechos de los usuarios'),
            TextSubtitleWidget(subtitle: 'Los usuarios tienen derecho a:'),
            TextSubtitleWidget(
                subtitle: 'Acceder y corregir sus datos personales.'),
            TextSubtitleWidget(
                subtitle: 'Solicitar la eliminación de sus datos personales.'),
            TextSubtitleWidget(
                subtitle:
                    'Recibir información sobre cómo se están utilizando sus datos.'),
            SizedBox(
              height: 5,
            ),
            TextTitleWidget(title: 'Derechos de los usuarios'),
            TextSubtitleWidget(
                subtitle:
                    'Al utilizar la aplicación, los usuarios aceptan los términos y condiciones de este tratado de datos y otorgan su consentimiento para la recopilación, procesamiento y almacenamiento de sus datos.'),
            SizedBox(
              height: 5,
            ),
            TextTitleWidget(title: 'Cambios en el tratado de datos'),
            TextSubtitleWidget(
                subtitle:
                    'La aplicación se reserva el derecho de modificar este tratado de datos en cualquier momento. Los cambios se publicarán en la aplicación y se considerarán efectivos a partir de la fecha de publicación.'),
            SizedBox(
              height: 5,
            ),
            TextTitleWidget(title: 'Contacto'),
            TextSubtitleWidget(
                subtitle:
                    'Para cualquier pregunta o inquietud sobre este tratado de datos, por favor ponerse en contacto a los correos:'),
            TextSubtitleWidget(subtitle: 'roger.ruizb@ug.edu.ec'),
            TextSubtitleWidget(subtitle: 'justin.delgadopig@ug.edu.ec'),
            SizedBox(
              height: 5,
            ),
            FilledButtonWidget(
                onPressed: () {
                  final fp =
                      Provider.of<FunctionalProvider>(context, listen: false);
                  fp.dismissAlert(key: widget.keyDismiss);
                },
                text: 'Aceptar')
          ],
        ),
      ),
    );
  }
}
