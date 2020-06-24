import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tak/Dict/Dictionary.dart';
import 'package:tak/Functions/Validators/Ean13.dart';
import 'package:tak/Objects/Item.dart';
import 'package:tak/Functions/ImagePicker.dart' as IMG;

class FormItemPageController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da FormItemPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  bool _autovalidate = false;               // Controle de validação do formulário
  final formKey = GlobalKey<FormState>();
  
  Item _newItem = new Item();
  String _appBarText = phrases['newItem'];
  String _ean13Result;                // Mostra o resultado de que o Código de Barras é valido  
  String _ean13Value;                 // Valor atual do Código de Barras no campo do Formulário

  void initialize(Item item){
    if(item != null){
      this._newItem = item;
      this._streamController.add(this._newItem);
      this._ean13Value = item.id;
      this._streamController.add(this._ean13Value);
      this._appBarText = phrases['editItem'];
      this._streamController.add(this._appBarText);
    }
  }

  void savePrice(String value){
    value = value.replaceAll(',', '.');
    double price = double.parse(value);
    this._newItem.price = price;
    this._streamController.add(this._newItem);
  }

  String get appBarText => this._appBarText;
  String get ean13Result => this._ean13Result;
  set ean13Value(String value){
    this._ean13Value = value;
    this._streamController.add(this._ean13Value);
  }
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
    String img = await IMG.imagePicker(200,200,70);
    if(img != null){
       this._newItem.img = img;
       print('\n Imagem: '+this._newItem.img+'\n');
       this._streamController.add(this._newItem);
    }
    
  }

  // Getters do formulário
  bool get autoValidate => this._autovalidate;

  String get name => (this._appBarText == phrases['newItem'])? null : this._newItem.name;
  String get id => (this._appBarText == phrases['newItem'])? null : this._newItem.id;
  String getPrice() => (this._appBarText == phrases['newItem'])? null : this._newItem.price.toStringAsFixed(2).replaceAll('.', ',');

  // Setters do Formulário
  set name(String value){
    this._newItem.name = value;
    this._streamController.add(this._newItem);
  }

  set id (String value){
    this._newItem.id = value;
    this._streamController.add(this._newItem);
  }

  Future<void> submit(BuildContext context) async{
    this._ean13Result = await ean13Validator(this._ean13Value,(this._newItem != null)? this._newItem.id : '');
    this._streamController.add(this._ean13Result);
    if(this.formKey.currentState.validate()){
      this.formKey.currentState.save();
      Navigator.pop(context, this._newItem);
    }else{
      this._autovalidate = true;
      this._streamController.add(this._autovalidate);
    }
  }
}
