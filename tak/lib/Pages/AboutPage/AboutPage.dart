import 'package:flutter/material.dart';
import 'package:tak/Controllers/AboutPageController/AboutPageController.dart';
import 'package:tak/Theme/theme.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final AboutPageController _controller = new AboutPageController();

  @override
  void initState(){
    this._controller.initPackageInfo();
    super.initState();
  }


  @override
  void dispose(){
    this._controller.close;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot){
    return Scaffold(
      backgroundColor: primary_color,
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Tak', style: TextStyle(fontFamily: 'Merienda One',fontSize: 120,color: background_color)),
            Text('Versão: ${this._controller.packageInfo.version}', style: TextStyle(fontFamily: 'Open Sans', fontSize: 20, color: background_color)),
            SizedBox(height: 50),
            Text('Desenvolvido por Evoluis Cooperativa de Programação, sob a licença BSD 3-Clause', style: TextStyle(fontFamily: 'Open Sans', fontSize: 20, color: background_color), textAlign: TextAlign.center)
          ],
        ),
      )
    );
      }
    );
  }
}
