import 'package:flutter/material.dart';
import 'package:tak/Objects/SlideLeftTransition.dart';
import 'package:tak/Pages/SalePage/SalePage.dart';
import 'package:tak/Pages/pages.dart';


Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case '/':
      return MaterialPageRoute(builder: (_) => HomePage());

    case '/listItems':
     return SlideLeftTransition(page: ItemsPage());
    
    case '/newSale':
      return SlideLeftTransition(page: SalePage());

    case '/newSale/addItem':
      return SlideLeftTransition(page: AddItemPage());

    case '/company':
      return SlideLeftTransition(page: CompanyPage());  
         
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text('Não existe rota defininda por ${settings.name}')),
            )
          );
  }
}

//import 'package:flutter/material.dart';
class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;
  SlideLeftRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.5, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        );
}