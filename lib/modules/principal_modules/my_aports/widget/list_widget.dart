import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class ListWidget extends StatefulWidget {
  final bool isGeneral;
  const ListWidget({super.key,  this.isGeneral = true});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Psittacus_erithacus_qtl1.jpg/1200px-Psittacus_erithacus_qtl1.jpg',
                      height: responsive.hp(10),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextTitleWidget(
                        title: 'Nombre Especie',
                        showShadow: false,
                      ),
                      TextSubtitleWidget(subtitle: '2024/02/13'),
                      Visibility(
                        visible: !widget.isGeneral,
                        child: _statePublish(0, responsive)),
                        Visibility(
                          visible: widget.isGeneral,
                          child: TextSubtitleWidget(subtitle: 'User',))
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 24,
                  color: AppTheme.primaryColor,
                )
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  _statePublish(int status, Responsive responsive) {
    switch (status) {
      case 0:
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.yellow, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: 'Enviado')),
        );

      case 1:
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.green, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: 'Aprobado')),
        );
      case 2:
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.red, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: 'Rechazado')),
        );

      default:
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.error, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: 'Aprobado')),
        );
    }
  }
}
