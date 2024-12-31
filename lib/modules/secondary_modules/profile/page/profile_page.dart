import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/widget/layout_generic.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class ProfilePage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> keyDismiss;
  const ProfilePage({super.key, required this.keyDismiss});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editable = false;
  TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return LayoutPageGeneric(
      keyDismiss: widget.keyDismiss,
      requiredStack: false,
      nameInterceptor: 'ProfilePage',
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextSubtitleWidget(
              subtitle: 'Perfil',
              size: 20,
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                AppTheme.iconUser,
                height: responsive.hp(10),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: TextTitleWidget(
                title: 'User User',
                size: responsive.wp(5.5),
              ),
            ),
            
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextTitleWidget(title: 'Correo'),
            ),
            
            TextSubtitleWidget(subtitle: 'correo@correo.com'),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextTitleWidget(title: 'Nombres'),
            ),
            TextSubtitleWidget(subtitle: 'USUARIO NOMBRE'),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextTitleWidget(title: 'Apellidos'),
            ),
            TextSubtitleWidget(subtitle: 'USUARIO APELLIDO'),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextTitleWidget(title: 'Telefono'),
            ),
            TextSubtitleWidget(subtitle: '0978907712'),
            const SizedBox(
              height: 20,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextTitleWidget(title: 'Notitificaciones'),
                Switch(value: true, onChanged: (value){}, activeTrackColor: AppTheme.primaryColor,)
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: TextSubtitleWidget(subtitle: 'Version 1.0.0'),
            )

          ],
        ),
      ),
    );
  }

 
}
