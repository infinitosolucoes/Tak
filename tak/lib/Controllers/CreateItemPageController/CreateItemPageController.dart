import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tak/Objects/Item.dart';

class CreateItemPageController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da CreateItemPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  bool _autovalidate = false;               // Controle de validação do formulário
  final formKey = GlobalKey<FormState>();

  String _appBarText = 'Novo Item';

  String get appBarText => this._appBarText;
  set appBarText(String value){
    this._appBarText = value;
    this._streamController.add(this._appBarText);
  }

  Item _newItem = new Item();

  Item get newItem => this._newItem; 
  set item(Item item){
    this._newItem = item;
    this._streamController.add(this._newItem);
  }
  ImageProvider get image { 
    if (this._newItem.img  == null){ 
      return AssetImage('images/food.png');
    }else{ 
      Uint8List image = base64Decode(this._newItem.img);
      return MemoryImage(image);
    }
  }
  Future setImage() async{
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(image != null){
      List<int> imageBytes = image.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
       this._newItem.img = base64Image;
       print('\n Imagem: '+this._newItem.img+'\n');
       this._streamController.add(this._newItem);
    }
    
  }

  // Getters do formulário
  bool get autoValidate => this._autovalidate;

  String get name => (this._appBarText == 'Novo Item')? null : this._newItem.name;
  String get id => (this._appBarText == 'Novo Item')? null : this._newItem.id;
  String getPrice() => (this._appBarText == 'Novo Item')? null : this._newItem.price.toString().replaceAll('.', ',');

  // Setters do Formulário
  set name(String value){
    this._newItem.name = value;
    this._streamController.add(this._newItem);
  }

  set id (String value){
    this._newItem.id = value;
    this._streamController.add(this._newItem);
  }

  set price (double value){
    this._newItem.price = value;
    this._streamController.add(this._newItem);
  }

  bool submit(){
    if(this.formKey.currentState.validate()){
      this.formKey.currentState.save();
      return true;
    }else{
      this._autovalidate = true;
      this._streamController.add(this._autovalidate);
      return false;
    }
  }
}