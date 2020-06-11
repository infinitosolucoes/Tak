import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tak/Objects/Sale.dart';
import 'package:tak/Objects/SaleItem.dart';
import 'package:tak/Objects/Company.dart';

import 'package:tak/Functions/RoundPrice.dart' as RoundPrice;

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
    try{
      double value = RoundPrice.roundPrice((this._newSale.total + saleItem.calculateTotal()));
     
      this._newSale.total = value;
      this._newSale.items.add(saleItem);
      
      this._streamController.add(this._newSale);
    }catch(e){
      print(e.toString());
    }
  }

  void decrementTotal(int index){
    try{
      SaleItem saleItem = this._newSale.items[index];
      double value = RoundPrice.roundPrice((this._newSale.total - saleItem.calculateTotal()));

      this._newSale.total = value;
      this._newSale.items.removeAt(index);
      
      this._streamController.add(this._newSale);
    }catch(e){
      print(e.toString());
    }
  }

  void setMethod(int value){
    this._newSale.methodPayment = value;
    this._streamController.add(this._newSale);
  }

  SaleItem getSaleItem(int index) => this._newSale.items[index];
  
  double getTotal() => this._newSale.total;
  
  int len() => this._newSale.items.length;

  ImageProvider getImageItem(SaleItem item) { 
    if (item.item.img  == null){ 
      return AssetImage('images/food.png');
    }else{ 
      Uint8List image = base64Decode(item.item.img);
      return MemoryImage(image);
    }
  }

  bool invoice() => (this._newSale.items.length > 0)? true : false;

}
