import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tak/Dict/Dictionary.dart';
import 'package:tak/Objects/Sale.dart';
import 'package:tak/Objects/SaleItem.dart';

import 'package:tak/Functions/Text/RoundPrice.dart' as RoundPrice;
import 'package:tak/Functions/List/GetSales.dart' as Sales;
import 'package:tak/Functions/Dialog.dart' as Dialog;

class SalePageController {
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da SalePage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream. Obs.: Deve ser chamado na função dispose da SalePage

  final Firestore _firestore = Firestore.instance;
  Sale _newSale;
  
  Future<void> createItem() async {
    List<Sale> sales = await Sales.loadItems(this._firestore);
    this._newSale = new Sale(
      id: (sales.length+1).toString(),
      total: 0.00,
      methodPayment: 1,
      items: new List<SaleItem>(),
      date: DateTime.now().toString().split(' ')[0]
    );
    this._streamController.add(this._newSale);
  }
  
  Sale get newSale => this._newSale;

  Future<void> add(BuildContext context) async {
    var newSaleItem =  await Navigator.pushNamed(context, routes['addItem']);
    this._incrementTotal(newSaleItem);
  }

  void _incrementTotal(SaleItem saleItem){
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

  Future<void> invoice(BuildContext context) {
    if(this._newSale.items.length > 0){
      Navigator.pushNamed(context, routes['invoice'], arguments: this._newSale);
    }else{
      Dialog.dialog(context,phrases['itemLength']);
    }
  }

}
