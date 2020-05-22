import 'dart:async';

import 'package:tak/Objects/Company.dart';
import 'package:tak/Objects/Sale.dart';

class InvoiceListPageController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da InvoiceListPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  List<Sale> _sales;

  List<Sale> get sales => this._sales;

  int len() => this._sales.length;

  String title(int index) => '${this._sales[index].id} - ${this._sales[index].date}';

  void initialize(){
    this._sales = company.sales.reversed.toList();
    this._streamController.add(this._sales);
  }
}