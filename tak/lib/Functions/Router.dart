import 'package:flutter/material.dart';
import 'package:tak/Pages/SalePage/SalePage.dart';
import 'package:tak/Pages/pages.dart';


Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case '/':
      return MaterialPageRoute(builder: (_) => HomePage());

    case '/listItems':
      return MaterialPageRoute(builder: (_) => ItemsPage());
    
    case '/newSale':
      return MaterialPageRoute(builder: (_) => SalePage());
      
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text('Não existe rota defininda por ${settings.name}')),
            )
          );
  }
}