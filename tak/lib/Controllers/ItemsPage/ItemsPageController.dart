import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tak/Dict/Dictionary.dart';
import 'package:tak/Functions/List/GetItems.dart' as Items;
import 'package:tak/Functions/Convert/Convert.dart' as Convert;
import 'package:tak/Objects/Company.dart';
import 'package:tak/Objects/Item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ItemsPageController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da ItemsPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  final Firestore _firestore = Firestore.instance;
  List<Item> _items = [];

  Item getItem(int index) => this._items[index];

  int len() => this._items.length;
  
  SnackBar _snackbar = SnackBar(
    content: Text(phrases['deleteSuccess']),
  );

  // Carrega os itens vindos do BD
  Future initialize() async {
    this._items = await Items.loadItems();
    this._streamController.add(this._items);
  }

  Future add(BuildContext context) async {
    final item = await Navigator.pushNamed(context, routes['createItem'], arguments: null);
    if(item != null){
      this._addItem(item);
    }
  }

  Future edit(BuildContext context, int index, Item item) async {
    final editItem = await Navigator.pushNamed(context, routes['createItem'], arguments: item);
    if(editItem != null){
      this._setItem(index,editItem);
    }
  }

  Future delete(BuildContext context, int index) async {
    bool flag = await this._removeItem(index);
    if(flag){
      Scaffold.of(context).showSnackBar(this._snackbar);
    }
  }

  Future<bool> _removeItem(int index) async {
    try{
      this._items.removeAt(index);
      final user = await FirebaseAuth.instance.currentUser();

      this._firestore.collection("companies").document(user.email).updateData({'items': Convert.convertListItemsToJson(this._items)}).then((_) {print("Salvado com sucesso");});
      this._streamController.add(this._items);
      return true;
    }catch (e){
      Exception('Index fora do range');
      return false;
    }
    
  }

  void _addItem(Item item) async {
    this._items.add(item);
    final user = await FirebaseAuth.instance.currentUser();

    this._firestore.collection("companies").document(user.email).updateData({'items': Convert.convertListItemsToJson(this._items)}).then((_) {print("Salvado com sucesso");});
    this._streamController.add(company);
  }

  void _setItem(int index, Item item) async {
    this._items[index] = item;
    final user = await FirebaseAuth.instance.currentUser();

    this._firestore.collection("companies").document(user.email).updateData({'items': Convert.convertListItemsToJson(this._items)}).then((_) {print("Salvado com sucesso");});
    this._streamController.add(company);
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
