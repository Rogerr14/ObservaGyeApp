// import 'package:animate_do/animate_do.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/button_general_widget.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/text_button_widget.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
// import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';

class AlertLoading extends StatelessWidget {
  const AlertLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
          // height: 110,
          // width: 100,
          child: Center(
        child: Image.asset(AppTheme.loading),
      )),
    );
  }
}

class AlertTemplate extends StatefulWidget {
  final Widget content;
  final GlobalKey keyToClose;
  final bool? dismissAlert;
  final bool? animation;
  final double? padding;
  const AlertTemplate(
      {super.key,
      required this.content,
      required this.keyToClose,
      this.dismissAlert,
      this.animation,
      this.padding});

  @override
  State<AlertTemplate> createState() => _AlertTemplateState();
}

class _AlertTemplateState extends State<AlertTemplate> {
  late GlobalKey keySummoner;

  @override
  Widget build(BuildContext context) {
    return ZoomOut(
        controller: (controller) {
          //animateController = controller;
          //debugPrint('controller de animacion ZoomIn: $controller' );
          // _typeAnimation('zoom-in', animationController);
        },
        animate: false,
        duration: const Duration(milliseconds: 200),
        child: Scaffold(
          backgroundColor: Colors.black45,
          body: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  final fp =
                      Provider.of<FunctionalProvider>(context, listen: false);
                  widget.dismissAlert == true
                      ? fp.dismissAlert(key: widget.keyToClose)
                      : null;
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                ),
              ),
              Container(
                padding: EdgeInsets.all(widget.padding ?? 20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // /const Expanded(child: SizedBox()),
                        widget.animation == true
                            ? FadeInUpBig(
                                animate: true,
                                controller: (controller) {
                                  //animateController = controller;
                                  //debugPrint('controller de animacion FadeInUpBig');
                                  //_typeAnimation('fade-in-up-big', animetionControllerContent);
                                },
                                duration: const Duration(milliseconds: 500),
                                child: widget.content)
                            : widget.content,
                        // const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class AlertGeneric extends StatefulWidget {
  final bool dismissable;
  final GlobalKey? keyToClose;
  final Widget content;
  final bool? heightOption;
  final bool? noPadding;

  const AlertGeneric(
      {super.key,
      required this.content,
      this.heightOption = false,
      this.dismissable = false,
      this.keyToClose,
      this.noPadding = false});

  @override
  State<AlertGeneric> createState() => _AlertGenericState();
}

class _AlertGenericState extends State<AlertGeneric> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          //margin: EdgeInsets.all(50),
          padding: widget.noPadding!
              ? const EdgeInsets.symmetric(vertical: 20)
              : const EdgeInsets.all(15),
          width: double.infinity,
          height: widget.heightOption == true ? size.height * 0.54 : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.white,
          ),
          child:
              Material(type: MaterialType.transparency, child: widget.content),
        ),
        if (widget.dismissable)
          Positioned(
            top: -3,
            right: 0,
            child: SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  final fp =
                      Provider.of<FunctionalProvider>(context, listen: false);
                  fp.dismissAlert(key: widget.keyToClose!);
                },
              ),
              // CloseButton(
              //   style: const ButtonStyle(
              //       iconColor: MaterialStatePropertyAll(AppTheme.hinText)),
              //   onPressed: () {
              //     final fp =
              //         Provider.of<FunctionalProvider>(context, listen: false);
              //     fp.dismissAlert(key: widget.keyToClose!);
              //   },
              // ),
            ),
          )
      ],
    );
  }
}

class ErrorGeneric extends StatelessWidget {
  final GlobalKey keyToClose;
  final String message;
  final String? messageButton;
  final void Function()? onPress;
  final bool closeSession;

  const ErrorGeneric(
      {super.key,
      this.closeSession = false,
      required this.message,
      required this.keyToClose,
      this.messageButton,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final responsive = Responsive(context);

    return Column(
      children: [
        Icon(
          Icons.highlight_remove,
          size: size.height * 0.07,
          color: AppTheme.error,
        ),
        // SizedBox(height: size.height * 0.005),
        const Text(
          'Error',
          style: TextStyle(
              fontSize: 30,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          message,
          style: const TextStyle(
              fontSize: 20,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold),
        ),

        SizedBox(height: size.height * 0.03),
        ButtonGeneralWidget(
          nameButton: 'Aceptar',
          backgroundColor: AppTheme.error,
          height: size.height * 0.05,
          width: size.width * 0.4,
          textColor: AppTheme.white,
          onPressed: (onPress != null)
              ? onPress
              : () async {
                  final fp =
                      Provider.of<FunctionalProvider>(context, listen: false);
                  fp.dismissAlert(key: keyToClose);
                },
        ),

        SizedBox(height: size.height * 0.01),
      ],
    );
  }
}

class GpsSelectUbication extends StatefulWidget {
  final void Function()? onPress;
  final GlobalKey keyToClose;
  final Function(LatLng latLng) onSelectPosition;
  Set<Marker> markers;
  GpsSelectUbication({
    super.key,
    this.onPress,
    required this.keyToClose,
    required this.onSelectPosition,
    this.markers = const {},
  });

  @override
  State<GpsSelectUbication> createState() => _GpsSelectUbicationState();
}

class _GpsSelectUbicationState extends State<GpsSelectUbication> {
  CameraPosition localizationMap = const CameraPosition(
    target: LatLng(
      -2.1832355790582962,
      -80.01632771534288,
    ),
    zoom: 14,
  );


  // Location location = Location();
  bool permiseEnable = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.015,
        ),
        TextTitleWidget(title: 'Seleccione la ubicacion de la alerta'),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          width: size.width * 0.8,
          height: size.height * 0.6,
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.satellite,
                markers: widget.markers,
                onTap: widget.onSelectPosition,
                initialCameraPosition: localizationMap,
                myLocationEnabled: true,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FilledButtonWidget(
                  onPressed: () async{
                    // permiseEnable = await location.serviceEnabled();
                    // if(!permiseEnable){
                      // final ubication = await location.getLocation();
                      // if(ubication.latitude != null && ubication.longitude != null){
                      // widget.markers = {Marker(markerId: MarkerId('1'), position: LatLng(ubication.latitude!, ubication.longitude!))};
                        
                      // }
                    // }
                  },
                  text: 'Usar mi ubicación',
                  width: 40,
                  color: AppTheme.secondaryColor,
                  colorText: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: widget.onPress ??
                  () {
                    final fp =
                        Provider.of<FunctionalProvider>(context, listen: false);
                    fp.dismissAlert(key: widget.keyToClose);
                  },
              child: const Text(
                'Aceptar',
                style: TextStyle(fontSize: 15, color: AppTheme.primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomDatePickerAlert extends StatelessWidget {
  final DateTime initialDate;
  final DateTime? lastDate;

  final DateTime? firstDate;
  final GlobalKey keyToClose;
  final void Function(DateTime) onDateSelected;
  final void Function()? onPress;

  const CustomDatePickerAlert({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
    required this.keyToClose,
    this.lastDate,
    this.onPress,
    this.firstDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Theme(
            data: Theme.of(context).copyWith(
                colorScheme:
                    const ColorScheme.light(primary: AppTheme.primaryColor),
                datePickerTheme: const DatePickerThemeData(
                    dayStyle: TextStyle(color: AppTheme.primaryColor),
                    dayOverlayColor:
                        WidgetStatePropertyAll(AppTheme.primaryColor))),
            child: CalendarDatePicker(
              initialDate: initialDate,
              firstDate: firstDate ?? DateTime(1900),
              lastDate: lastDate ?? DateTime(2030),
              onDateChanged: (DateTime date) {
                onDateSelected(date);
              },
              initialCalendarMode: DatePickerMode.day,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: onPress ??
                  () {
                    final fp =
                        Provider.of<FunctionalProvider>(context, listen: false);
                    fp.dismissAlert(key: keyToClose);
                  },
              child: const Text(
                'Aceptar',
                style: TextStyle(fontSize: 15, color: AppTheme.primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ConfirmContent extends StatelessWidget {
  final String message;
  final void Function() confirm;
  final void Function() cancel;
  const ConfirmContent(
      {super.key,
      required this.message,
      required this.confirm,
      required this.cancel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final responsive = Responsive(context);
    return Column(
      children: [
        SizedBox(height: size.height * 0.015),
        //SvgPicture.asset(AppTheme.iconCheckPath),
        const SizedBox(height: 15),
        messageAlerts(size, message: message, fontSize: 17),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButtonWidget(
              onPressed: cancel,
              text: 'Cancelar',
              fontSize: 17,
              color: AppTheme.error,
            ),
            SizedBox(width: size.width * 0.08),
            FilledButtonWidget(
              onPressed: confirm,
              width: size.width * 0.05,
              text: 'Confirmar',
              color: AppTheme.primaryColor,
            )
          ],
        ),
        SizedBox(height: size.height * 0.01),
      ],
    );
  }
}

Padding messageAlerts(Size size,
    {required String message, required double fontSize}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
    child: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: AppTheme.primaryColor,
      ),
    ),
  );
}

class OkGeneric extends StatelessWidget {
  final GlobalKey keyToClose;
  final String message;
  // final String? messageButton;
  final void Function()? onPress;
  // final bool closeSession;

  const OkGeneric(
      {super.key,
      // this.closeSession = false,
      required this.message,
      required this.keyToClose,
      // this.messageButton,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final responsive = Responsive(context);

    return Column(
      children: [
        Icon(
          Icons.check_circle,
          size: size.height * 0.07,
          color: AppTheme.primaryColor,
        ),
        SizedBox(height: size.height * 0.01),
        Align(
          alignment: Alignment.center,
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.03),
        ButtonGeneralWidget(
          nameButton: 'Aceptar',
          backgroundColor: AppTheme.primaryColor,
          height: size.height * 0.05,
          width: size.width * 0.4,
          textColor: AppTheme.white,
          onPressed: (onPress != null)
              ? onPress
              : () async {
                  final fp =
                      Provider.of<FunctionalProvider>(context, listen: false);
                  fp.dismissAlert(key: keyToClose);
                },
        ),
        SizedBox(height: size.height * 0.01),
      ],
    );
  }
}

class NoExistInformation extends StatelessWidget {
  final String message;
  final void Function() function;
  final String? namePage;
  final bool? isNamePage;

  const NoExistInformation({
    Key? key,
    required this.message,
    required this.function,
    this.namePage = '',
    this.isNamePage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.015),
        SvgPicture.asset(AppTheme.iconCautionPath),
        const SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.027),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: message,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.primaryColor),
              children: <TextSpan>[
                isNamePage == true
                    ? TextSpan(
                        text: ' $namePage.',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.hinText),
                      )
                    : const TextSpan(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 25),
        FilledButtonWidget(
          color: AppTheme.primaryColor,
          onPressed: function,
          width: size.width * 0.05,
          text: 'Aceptar',
          colorText: AppTheme.white,
        ),
        SizedBox(height: size.height * 0.01),
      ],
    );
  }
}
// class CustomAlert extends StatelessWidget {
//   final GlobalKey keyToClose;
//   final IconData icon;
//   final String message;
//   final String? messageButton;
//   final void Function()? onPress;
//   final bool closeSession;

//   const CustomAlert(
//       {super.key,
//       this.closeSession = false,
//       required this.message,
//       required this.keyToClose,
//       this.messageButton,
//       this.onPress, required this.icon});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     // final responsive = Responsive(context);

//     return Column(
//       children: [
//         Icon(
//           Icons.highlight_remove,
//           size: size.height * 0.07,
//           color: AppTheme.error,
//         ),
//         // SizedBox(height: size.height * 0.005),
//         const Text(
//           'Error',
//           style: TextStyle(
//               fontSize: 30,
//               color: AppTheme.primaryColor,
//               fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: size.height * 0.01),
//         Text(
//           message,
//           style: const TextStyle(
//               fontSize: 20,
//               color: AppTheme.primaryColor,
//               fontWeight: FontWeight.bold),
//         ),

//         SizedBox(height: size.height * 0.03),
//         ButtonGeneralWidget(
//           nameButton: 'Aceptar',
//           backgroundColor: AppTheme.error,
//           height: 30,
//           width: 120,
//           textColor: AppTheme.white,
//           onPressed: (onPress != null)
//               ? onPress
//               : () async {
//                   final fp =
//                       Provider.of<FunctionalProvider>(context, listen: false);
//                   fp.dismissAlert(key: keyToClose);
//                 },
//         ),

//         SizedBox(height: size.height * 0.01),
//       ],
//     );
//   }
// }
