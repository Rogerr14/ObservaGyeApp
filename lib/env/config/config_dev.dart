
import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/config/config_base.dart';

class DevEnv extends BaseConfig{
  
  @override
  String get appName => 'ObservaGye';

  @override

    // String get serviceUrl => 'http://192.168.100.6:2500/api'; // home
    String get serviceUrl => 'http://10.10.80.168:2500/api';
    // String get serviceUrl => 'http://192.168.10.113:2500/api';//work

  @override
  Color get primaryColor => const Color(0xFF0D47A1);
}