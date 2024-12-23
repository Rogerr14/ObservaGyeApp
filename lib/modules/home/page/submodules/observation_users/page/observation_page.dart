import 'package:flutter/material.dart';
import 'package:observa_gye_app/shared/widget/card_lista_widget.dart';
import 'package:observa_gye_app/shared/widget/layout.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class ObservationPage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> keyDismiss;
  const ObservationPage({super.key, required this.keyDismiss});

  @override
  State<ObservationPage> createState() => _ObservationPageState();
}

class _ObservationPageState extends State<ObservationPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
        keyDismiss: widget.keyDismiss,
        requiredStack: false,
        nameInterceptor: 'ObservationPage',
        child:  Padding(
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
                  child: TextTitleWidget(title: 'Observaciones'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                   itemCount: 2,
                  itemBuilder: (context, index) => CardListaWidget(ulrImagen: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Psittacus_erithacus_qtl1.jpg/1200px-Psittacus_erithacus_qtl1.jpg', title: 'jola', subtitle: 'ss', onPressed: (){}),),
              )
            ],
          ),
        ));
  }
}
