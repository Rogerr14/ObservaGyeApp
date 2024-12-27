import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/404/pages/page_404.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/routes/app_routes.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppTheme.connectionImage,
          height: size.height * 0.4,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextTitleWidget(
            title:
                'Visualiza los avistamientos y alertas de la comunidad. ',
            showShadow: false,
            color: AppTheme.white,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        
      ],
    );
  }
}
