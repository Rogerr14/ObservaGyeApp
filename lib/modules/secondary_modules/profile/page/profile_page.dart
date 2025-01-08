import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/security/login/model/user_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/helpers/secure_storage.dart';
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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  UserModel? userModel;
  bool _editable = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    userModel = await SecureStorage().getUserData();
    _nameController.text = userModel!.name;
    _lastNameController.text = userModel!.lastName;
    _phoneController.text = userModel!.phone;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return LayoutPageGeneric(
      keyDismiss: widget.keyDismiss,
      requiredStack: false,
      nameInterceptor: 'ProfilePage',
      iconSuffix: IconButton(
          onPressed: () {
            if (!_editable) {
              _editable = !_editable;
            } else {
              _editable = !_editable;
              
            }
            setState(() {});
          },
          icon: TextTitleWidget(title: !_editable ? 'Editar' : 'Guardar')),
      child: userModel == null
          ? SizedBox()
          : SingleChildScrollView(
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
                        title: '${userModel!.name} ${userModel!.lastName}',
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
                    TextSubtitleWidget(
                      subtitle: '${userModel!.email}',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: TextTitleWidget(title: 'Nombres'),
                    ),
                    _editable
                        ? TextFormFieldWidget(
                            controller: _nameController,
                          )
                        : TextSubtitleWidget(subtitle: userModel!.name),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: TextTitleWidget(title: 'Apellidos'),
                    ),
                    _editable
                    ? TextFormFieldWidget(
                      controller: _lastNameController,
                    ):

                    TextSubtitleWidget(subtitle: userModel!.lastName),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: TextTitleWidget(title: 'Telefono'),
                    ),
                    _editable 
                    ? TextFormFieldWidget(
                      controller: _phoneController,
                    ) 
                    : TextSubtitleWidget(subtitle: userModel!.phone),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextTitleWidget(title: 'Notitificaciones'),
                        Switch(
                          value: true,
                          onChanged: (value) {},
                          activeTrackColor: AppTheme.primaryColor,
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextSubtitleWidget(subtitle: 'Version 1.0.0'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
