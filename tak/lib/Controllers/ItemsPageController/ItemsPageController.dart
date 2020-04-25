import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tak/Objects/Company.dart';
import 'package:tak/Objects/Item.dart';

class ItemsPageController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da ItemsPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  Item getItem(int index) => company.items[index];

  int len() => company.items.length;

  void removeItem(int index){
    company.items.removeAt(index);
    this._streamController.add(company);
  }

  void addItem(Item item){
    company.items.add(item);
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