import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tak/Pages/SalePage/SalePage.dart';
import 'package:tak/Pages/pages.dart';


Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case '/':
      return CupertinoPageRoute(builder: (_) => HomePage());

    case '/listItems':
     return CupertinoPageRoute(builder: (_) => ItemsPage());

    case '/listItems/createItem':
      return CupertinoPageRoute(builder: (_) => FormItemPage(itemEdit: settings.arguments));
    
    case '/newSale':
      return CupertinoPageRoute(builder: (_) => SalePage());
      
    case '/invoice':
      return CupertinoPageRoute(builder: (_) => InvoicePage(sale: settings.arguments));

    case '/newSale/addItem':
      return CupertinoPageRoute(builder: (_) => AddItemPage());

    case '/salesReport':
      return CupertinoPageRoute(builder: (_) => SalesReportPage());

    case '/listInvoices':
     return CupertinoPageRoute(builder: (_) => InvoiceListPage());

    case '/company':
      return CupertinoPageRoute(builder: (_) => CompanyPage()); 

    case '/help':
      return CupertinoPageRoute(builder: (_) => HelpPage());  

    case '/help/about':
      return CupertinoPageRoute(builder: (_) => AboutPage());

    case '/login':
      return CupertinoPageRoute(builder: (_) => LoginPage());
         
    default:
      return CupertinoPageRoute(builder: (_) => ErrorPage());
  }
}
