import 'package:flutter/material.dart';
import 'package:tak/theme/theme.dart';
import 'package:tak/Objects/GridNavigator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Tamanho da Tela
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: background_color,
      appBar: AppBar(
        backgroundColor: primary_color,
        centerTitle: true,
        title: Text("Tak", style: home_app_bar,),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: (width*0.1),
        mainAxisSpacing: (height*0.04),
        padding: EdgeInsets.only(
          left: (width*0.11),
          top: (height*0.1),
          right:(width*0.11),
        ),
        children: List.generate(routes.length, (index){
          return RaisedButton(
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(routes[index].icon, size: (height*0.08), color: primary_color,),
                SizedBox(height: (height*0.01)),
                Text(routes[index].name ,style: titleGrid(height),)
              ]
            ),
            
            color: background_color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide( color: decoration_color, width: 1)
            ),
            onPressed: (){},
          );
        }),
      ),
    );
  }
}