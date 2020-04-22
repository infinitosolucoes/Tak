import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tak/Objects/Item.dart';

class CreateItemPageController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da CreateItemPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  bool _autovalidate = false;               // Controle de validação do formulário
  final formKey = GlobalKey<FormState>();

  Item _newItem = new Item();

  // Getters do formulário
  bool get autoValidate => this._autovalidate;

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
}