import 'package:flutter/material.dart';
import 'package:tak/Controllers/LoginPage/LoginPageController.dart';
import 'package:tak/Theme/Theme.dart';
import 'package:tak/Dict/Dictionary.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginPageController _controller = new LoginPageController();

  @override
  void dispose(){
    this._controller.close;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot){
        return Scaffold(
          backgroundColor: primary_color,
          body: Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(phrases['companyLogo'], style: companyLogo),
                  Text(phrases['catchphrase'], style: catchphrase),
                  
                  SizedBox(height: (height * 0.25)),
                  
                  FlatButton(
                    color: background_color,
                    textColor: primary_color,
                    child: Text(phrases['loginButton']),
                    onPressed: () async{await this._controller.login(context);},
                  )
                ],
              )
            ),
          )
        );
      }
    );
  }


}
