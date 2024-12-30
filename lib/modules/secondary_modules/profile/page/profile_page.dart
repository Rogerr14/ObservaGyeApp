import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: TextSubtitleWidget(
                subtitle: 'Perfil',
                size: 20,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              AppTheme.iconUser,
              height: responsive.hp(10),
            ),
            const SizedBox(
              height: 10,
            ),
            TextTitleWidget(
              title: 'User User',
              size: responsive.wp(5.5),
            ),
            
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextTitleWidget(title: 'Correo'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(child: TextFormFieldWidget(enabled: editable,)),
                IconButton(onPressed: (){
                  editable = !editable;
                  setState(() {
                    
                  });
                }, icon: Icon(Icons.edit))
                
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextTitleWidget(title: 'Nombres'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextTitleWidget(title: 'Apellidos'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextTitleWidget(title: 'Telefono'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextTitleWidget(title: 'Contaseña'),
            ),
          ],
        ),
      ),
    );
  }

 
}
