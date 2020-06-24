import 'dart:async';

import 'package:tak/Functions/List/GetSales.dart' as Sales;
import 'package:tak/Objects/Sale.dart';

class InvoiceListPageController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da InvoiceListPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream


  List<Sale> _sales = [];

  List<Sale> get sales => this._sales;

  int len() => this._sales.length;

  Sale sale(int index) => this._sales[index];

  String title(int index) => '${this._sales[index].id} - ${this._sales[index].date}';

  void initialize() async{
   
    this._sales = await Sales.loadSales();
    this._streamController.add(this._sales);
  }
}