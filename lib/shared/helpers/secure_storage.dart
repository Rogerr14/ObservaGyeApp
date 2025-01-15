


import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:observa_gye_app/modules/security/login/model/user_model.dart';

class SecureStorage{

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true);

  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());



  void setUserData(UserModel userModel)async{
    final data =  jsonEncode(userModel);
    await storage.write(key: 'userData', value: data);
  }


  Future<UserModel?> getUserData()async{
    final data = await storage.read(key: 'userData');
    if(data != null){
      UserModel userModel = userModelFromJson(data);
      return userModel;
    } 
    return null;
  }

  void removeData()async{
    await storage.delete(key: "userData");
  }




  void setInfomation(String view)async{
    await storage.write(key: 'slider', value: view);
  }

  Future<bool> getInformation()async{
    final data = await storage.read(key: 'slider');
    if(data == 'true'){
      return true;
    }else{
      return false;
    }
  }

}