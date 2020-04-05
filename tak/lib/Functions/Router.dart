import 'package:flutter/material.dart';
import 'package:tak/HomePage/HomePage.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case '/':
      return MaterialPageRoute(builder: (_) => HomePage());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text('Não existe rota defininda por ${settings.name}')),
            )
          );
  }
}