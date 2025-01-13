import 'package:observa_gye_app/env/config/config_base.dart';
import 'package:observa_gye_app/env/config/config_dev.dart';
import 'package:observa_gye_app/env/config/config_prod.dart';
import 'package:observa_gye_app/env/config/config_qa.dart';

class Environment {
  static final Environment _environment = Environment._internal();

  factory Environment() => _environment;

  Environment._internal();

  static const String dev = 'DEV';

  static const String prod = 'PROD';

  static const String qa = 'QA';

  BaseConfig? config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.prod:
        return ProdEnv();
      case Environment.qa:
        return QaEnv();
      case Environment.dev:
        return DevEnv();
      default:
        return DevEnv();
    }
  }
}
