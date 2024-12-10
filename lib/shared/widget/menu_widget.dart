

// import 'package:flutter/material.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// import 'package:observa_gye_app/env/theme/apptheme.dart';
// import 'package:observa_gye_app/shared/helpers/global_helper.dart';

// class MenuWidget extends StatefulWidget {
//   const MenuWidget({super.key, required this.controller});

//   // final List<Opcione> opciones;

//   final ZoomDrawerController controller;

//   @override
//   State<MenuWidget> createState() => _MenuWidgetState();
// }

// class _MenuWidgetState extends State<MenuWidget> {
  
//   bool valor = false;
//   @override
//   void initState() {
//     super.initState();
  
//   }

 
//   @override
//   Widget build(BuildContext context) {
//     // final fp = Provider.of<FunctionalProvider>(context, listen: false);
//     final size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0, 90, 0, 20),
//       // width: ,
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Container(
//               // height: size.height * 0.70,
//               width: size.width,
//               decoration: BoxDecoration(
//                   // color: Colors.black,
//                   borderRadius: BorderRadius.circular(30)),
//               child: SingleChildScrollView(
//                 child: Column(
//                     children: opciones
//                         .map(
//                           (opcion) => Column(
//                             children: [
//                               SizedBox(
//                                 // height: 50,
//                                 width: size.width,
//                                 child: OutlinedButton(
//                                     style: OutlinedButton.styleFrom(
//                                         shape: RoundedRectangleBorder(
//                                             side: BorderSide.none),
//                                         side: BorderSide.none),
//                                     onPressed: () async {
//                                       // final fp =
//                                       //     Provider.of<FunctionalProvider>(
//                                       //         context,
//                                       //         listen: false);

//                                       // GlobalHelper.navigateToPageRemove(
//                                       //     context, opcion.ruta);
//                                       // fp.clearAllAlert();
//                                     },
//                                     child: OptionsMenuWidget(opcione: opcion)),

//                               ),
//                               const Divider()
//                             ],
//                           ),
//                         )
//                         .toList()),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 60),
//             child: TextButton.icon(
//                 onPressed: _closeSesion,
//                 icon: const Icon(Icons.logout_outlined,
//                     color: AppTheme.primaryColor),
//                 label: const Text(
//                   'Cerrar Sesion',
//                   style: TextStyle(color: AppTheme.primaryColor),
//                 )),
//           ),
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 60),
//               child: Switch(
//                   value: valor,
//                   onChanged: (value) {
//                     valor = value;
//                     setState(() {});
//                   }))
//         ],
//       ),
//     );
//   }

//   // _navigateTo(Opcione opcione) {
//   //   switch (opcione.tipo) {
//   //     case 'IN':
//   //       break;

//   //     case 'Ext':
//   //       launchUrl(Uri.parse(opcione.ruta),
//   //           mode: LaunchMode.externalApplication);
//   //       break;
//   //     case 'MD':
//   //       final aletrKey = GlobalHelper.genKey();
//   //       final fp = Provider.of<FunctionalProvider>(context, listen: false);
//   //       fp.showAlert(
//   //           key: aletrKey,
//   //           content: AlertGeneric(
//   //               content: CustomAlert(
//   //                   message: 'hola', keyToClose: aletrKey, icon: Icons.abc)));
//   //   }
//   // }

//   _closeSesion() {
//     widget.controller.close!();
//     final fp = Provider.of<FunctionalProvider>(context, listen: false);

//     final closeSesionkey = GlobalHelper.genKey();
//     fp.showAlert(
//         key: closeSesionkey,
//         content: AlertGeneric(
//             content: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               '¿Desea cerrar sesión?',
//               style: TextStyle(
//                 color: AppTheme.primaryColor,
//                 fontFamily: 'Roboto',
//                 fontSize: 25,
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ButtonGeneralWidget(
//                   nameButton: 'Cancelar',
//                   backgroundColor: AppTheme.red,
//                   height: 35,
//                   width: 130,
//                   textColor: AppTheme.withe,
//                   onPressed: () {
//                     fp.dismissAlert(key: closeSesionkey);
//                   },
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 ButtonGeneralWidget(
//                   nameButton: 'Aceptar',
//                   backgroundColor: AppTheme.yellow,
//                   height: 35,
//                   width: 130,
//                   textColor: AppTheme.withe,
//                   onPressed: () async{
//                     fp.clearAllAlert();
//                     await UserDataStorage().removeUserData();
//                     Navigator.pushReplacementNamed(context, '/login');
//                     // Navigator.pushAndRemoveUntil(
//                     //     context,
//                     //     LoginPage(),
//                     //     // GlobalHelper.navigationFadeIn(context, LoginPage()),
//                     //     (route) => false);
//                     // GlobalHelper.navigateToPageRemove(context, '/login');
//                   },
//                 ),
//               ],
//             )
//           ],
//         )));
//   }
// }

// //Diseño template de las opciones del menu

// class OptionsMenuWidget extends StatelessWidget {
//   const OptionsMenuWidget({super.key, required this.opcione});
//   final Opcione opcione;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               GlobalHelper().tipeIcon(opcione.icono.tipo, opcione.icono.ruta),
//               const SizedBox(
//                 width: 10,
//               ),
//               SizedBox(
//                 width: 120,
//                 child: RichText(
//                   text: TextSpan(
//                     text: opcione.nombre,
//                     style: const TextStyle(
//                       color: AppTheme.secondaryColor,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Divider(endIndent: 1,),
//           // SizedBox(height: 20,)
//         ],
//       ),
//     );
//   }
// }
