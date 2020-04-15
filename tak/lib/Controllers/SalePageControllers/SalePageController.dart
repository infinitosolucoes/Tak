import 'dart:async';

import 'package:tak/Objects/Sale.dart';
import 'package:tak/Objects/SaleItem.dart';

class SalePageController {
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  Sale newSale = new Sale(
    total: 0.00,
    methodPayment: 1,
    items: new List<SaleItem>()
  );

  void incrementTotal(SaleItem saleItem){
    if(saleItem != null){
      this.newSale.total += saleItem.calculateTotal();
      this.newSale.items.add(saleItem);
      this._streamController.add(this.newSale);
    }
  }

  void decrementTotal(int index){
    SaleItem saleItem = this.newSale.items[index];
    this.newSale.total -= saleItem.calculateTotal();
    this.newSale.items.removeAt(index);
    this._streamController.add(this.newSale);
  }

  void setMethod(int value){
    this.newSale.methodPayment = value;
    this._streamController.add(this.newSale);
  }

  SaleItem getSaleItem(int index){
    return this.newSale.items[index];
  }

  double getTotal(){
    return this.newSale.total;
  }

  int len(){
    return this.newSale.items.length;
  }

  void dispose(){
    this._streamController.close();
  }
}