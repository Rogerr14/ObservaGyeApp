
import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/config/config_base.dart';

class DevEnv extends BaseConfig{
  
  @override
  String get appName => 'MISOLCA';

  @override

  // String get serviceUrl => 'http://10.10.80.249:8910/';
    String get serviceUrl => 'http://172.16.50.175:8910/';

  @override
  Color get primaryColor => const Color(0xFF0D47A1);
}