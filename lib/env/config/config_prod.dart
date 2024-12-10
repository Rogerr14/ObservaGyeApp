
import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/config/config_base.dart';

class ProdEnv extends BaseConfig{
  @override
  String get appName => 'ObservaGye';

  @override
  String get serviceUrl => '';

  @override
  Color get primaryColor => const Color(0xFF0D47A1);
}