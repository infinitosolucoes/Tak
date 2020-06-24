import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tak/Functions/List/GetItems.dart' as Items;
import 'package:tak/Objects/Item.dart';
import 'package:tak/Objects/SaleItem.dart';

class AddItemController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da AddItemPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream


  List<Item> _items = [];
  SaleItem _new = new SaleItem(amount: 0, item: null);

  // Carrega os itens vindos do BD
  Future<void> initialize() async {
    this._items = await Items.loadItems();
    this._streamController.add(this._items);
  }

  void setItem(int index){
    this._new.item = this._items[index];
    this._streamController.add(this._new.item);
  }

  void setAmount(int amount){
    this._new.amount = amount;
    this._streamController.add(this._new.amount);
  }

  int getAmount(){
    return this._new.amount;
  }

  int len(){
    return this._items.length;
  }

  Item getItem(int index){
    return this._items[index];
  }

  bool isNull(){
    if((this._new.amount != 0) && (this._new.item != null)){
      return false;
    }
    return true;
  }

  SaleItem getSaleItem(){
    return this._new;
  }

  ImageProvider getImageItem(Item item) { 
    if (item.img  == null){ 
      return AssetImage('images/food.png');
    }else{ 
      Uint8List image = base64Decode(item.img);
      return MemoryImage(image);
    }
  }

}
