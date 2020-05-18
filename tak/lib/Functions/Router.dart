import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tak/Pages/SalePage/SalePage.dart';
import 'package:tak/Pages/pages.dart';


Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case '/':
      return MaterialPageRoute(builder: (_) => HomePage());

    case '/listItems':
     return CupertinoPageRoute(builder: (_) => ItemsPage());

    case '/listItems/createItem':
      return CupertinoPageRoute(builder: (_) => FormItemPage(itemEdit: settings.arguments));
    
    case '/newSale':
      return CupertinoPageRoute(builder: (_) => SalePage());
      
    case '/newSale/invoice':
      return CupertinoPageRoute(builder: (_) => InvoicePage(sale: settings.arguments));

    case '/newSale/addItem':
      return CupertinoPageRoute(builder: (_) => AddItemPage());

    case '/salesReport':
      return CupertinoPageRoute(builder: (_) => SalesReportPage());

    case '/company':
      return CupertinoPageRoute(builder: (_) => CompanyPage());  
         
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
