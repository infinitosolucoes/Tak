import 'dart:async';

import 'package:package_info/package_info.dart';

class AboutPageController{
  final StreamController _streamController = new StreamController.broadcast();
  
  Sink get input => _streamController.sink;                   // Entrada de dados da AboutPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  PackageInfo get packageInfo => this._packageInfo;

  Future<void> initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    
    this._packageInfo = info;
    this._streamController.add(this._packageInfo);
   
  }
}