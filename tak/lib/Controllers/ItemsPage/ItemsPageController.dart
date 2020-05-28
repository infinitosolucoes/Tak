import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tak/Objects/Company.dart';
import 'package:tak/Objects/Item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ItemsPageController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da ItemsPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  final Firestore firestore = Firestore.instance;

  Item getItem(int index) => company.items[index];

  int len() => company.items.length;

  SnackBar _snackbar = SnackBar(
    content: Text('Removido com sucesso'),
  );

  SnackBar get snackbar => this._snackbar;

  Future<bool> removeItem(int index) async {
    try{
      company.items.removeAt(index);
      final user = await FirebaseAuth.instance.currentUser();

    this.firestore.collection("companies").document(user.email).updateData({'items': company.convertListItemsToJson()}).then((_) {print("Salvado com sucesso");});
      this._streamController.add(company);
      return true;
    }catch (e){
      Exception('Index fora do range');
      return false;
    }
    
  }

  void addItem(Item item) async {
    company.items.add(item);
    final user = await FirebaseAuth.instance.currentUser();

    this.firestore.collection("companies").document(user.email).updateData({'items': company.convertListItemsToJson()}).then((_) {print("Salvado com sucesso");});
    this._streamController.add(company);
  }

  void setItem(int index, Item item) async {
    company.items[index] = item;
    final user = await FirebaseAuth.instance.currentUser();

    this.firestore.collection("companies").document(user.email).updateData({'items': company.convertListItemsToJson()}).then((_) {print("Salvado com sucesso");});
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
