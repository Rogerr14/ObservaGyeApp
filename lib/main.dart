import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:observa_gye_app/env/environment.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  String environment =  const String.fromEnvironment('ENVIRONMENT', defaultValue: Environment.dev);
  Environment().initConfig(environment);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appName = Environment().config?.appName ?? 'name app default';
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> FunctionalProvider(), )
      ],
      child: MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme().theme(),
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
