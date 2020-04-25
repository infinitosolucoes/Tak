import 'dart:async';
import 'package:tak/Objects/Company.dart';
import 'package:tak/Objects/Sale.dart';

class SalesReportPageController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da SalesReportPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  List<Sale> _list;

  void getListByDate(){
    if(company.sales.length != 0){
       DateTime date = new DateTime.now();
      int index;
      for(index = (company.sales.length - 1); (date.difference(DateTime.parse(company.sales[index].date)).inDays == 0) & (index >= 0); index--){}
      this._list = company.sales.sublist(index, company.sales.length);
    }else{
      this._list = [];
    }
    this._streamController.add(this._list);
  }

  int get len => this._list.length;
  double get amount {
    double total = 0;
    for (Sale sale in this._list) {
      total += sale.total;
    }
    return total;
  }
}