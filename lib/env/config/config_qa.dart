
import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/config/config_base.dart';

class QaEnv extends BaseConfig{
  
  @override
  String get appName => 'ObservaGye';

  @override

    // String get serviceUrl => 'http://192.168.100.6:2500/api';
    String get serviceUrl => 'https://organized-somalia-programme-clear.trycloudflare.com/api';
    // String get serviceUrl => 'http://192.168.10.113:2500/api';

  @override
  Color get primaryColor => const Color(0xFF0D47A1);
}