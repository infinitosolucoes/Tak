import 'dart:async';

import 'package:tak/Objects/Item.dart';
import 'package:tak/Objects/SaleItem.dart';

class AddItemController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  List<Item> _items = new List<Item>();
  SaleItem _new = new SaleItem(amount: 0, item: null);

  // Carrega os itens vindos do BD
  void loadItems(){
    this._items = items;
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

  void dispose(){
    this._streamController.close(); 
  }
}