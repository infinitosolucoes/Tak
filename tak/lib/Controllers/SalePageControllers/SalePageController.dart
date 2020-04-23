import 'dart:async';

import 'package:tak/Objects/Sale.dart';
import 'package:tak/Objects/SaleItem.dart';
import 'package:tak/Objects/Company.dart';

class SalePageController {
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da SalePage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream. Obs.: Deve ser chamado na função dispose da SalePage

  Sale _newSale = new Sale(
    total: 0.00,
    methodPayment: 1,
    items: new List<SaleItem>(),
    date: DateTime.now().toString()
  );

  void incrementTotal(SaleItem saleItem){
    if(saleItem != null){
      this._newSale.total += saleItem.calculateTotal();
      this._newSale.items.add(saleItem);
      this._streamController.add(this._newSale);
    }
  }

  void decrementTotal(int index){
    SaleItem saleItem = this._newSale.items[index];
    this._newSale.total -= saleItem.calculateTotal();
    this._newSale.items.removeAt(index);
    this._streamController.add(this._newSale);
  }

  void setMethod(int value){
    this._newSale.methodPayment = value;
    this._streamController.add(this._newSale);
  }

  SaleItem getSaleItem(int index){
    return this._newSale.items[index];
  }

  double getTotal(){
    return this._newSale.total;
  }

  int len(){
    return this._newSale.items.length;
  }

  bool finalizeSale(){
    try{
      if(this._newSale.total > 0){
        company.sales.add(this._newSale);
        print('\nRealizado com sucesso\n');
        return true;
      }
      return false;
    }catch(e){
      return false;
    }
  }

}