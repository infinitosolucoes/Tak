import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tak/Objects/Sale.dart';
import 'package:tak/Objects/SaleItem.dart';
import 'package:tak/Objects/Company.dart';

class SalePageController {
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da SalePage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream. Obs.: Deve ser chamado na função dispose da SalePage

  Sale _newSale = new Sale(
    id: (company.sales.length+1).toString(),
    total: 0.00,
    methodPayment: 1,
    items: new List<SaleItem>(),
    date: DateTime.now().toString().split(' ')[0]
  );
  
  Sale get newSale => this._newSale;

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

  ImageProvider getImageItem(SaleItem item) { 
    if (item.item.img  == null){ 
      return AssetImage('images/food.png');
    }else{ 
      Uint8List image = base64Decode(item.item.img);
      return MemoryImage(image);
    }
  }

  bool finalizeSale(){
    try{
      if(this._newSale.total > 0){
        company.sales.add(this._newSale);
        this._streamController.add(company);
        print(this._newSale.toString());
        return true;
      }
      return false;
    }catch(e){
      return false;
    }
  }

}
