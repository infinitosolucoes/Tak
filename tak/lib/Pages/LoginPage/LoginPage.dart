import 'package:flutter/material.dart';
import 'package:tak/Controllers/LoginPage/LoginPageController.dart';
import 'package:tak/Theme/theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginPageController _controller = new LoginPageController();

  // @override
  // void initState(){
  //   this._controller.initPackageInfo();
  //   super.initState();
  // }


  @override
  void dispose(){
    this._controller.close;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
		        Text('Tak', style: TextStyle(fontFamily: 'Merienda One',fontSize: 80,color: background_color)),
		        Text('O seu melhor ajudante ;)', style: TextStyle(fontFamily: 'Open Sans', fontSize: 18, color: background_color)),
		        
		        SizedBox(height: (height * 0.25)),
		        
		        
		        FlatButton(
		          color: background_color,
		          textColor: primary_color,
		          child: Text('LOGIN COM O GOOGLE'),
		          onPressed: () async{
                this._controller.signInWithGoogle().whenComplete(() {
                  Navigator.pushNamedAndRemoveUntil(context,'/', (Route<dynamic> route) => false);
                });
		            
		          },
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
