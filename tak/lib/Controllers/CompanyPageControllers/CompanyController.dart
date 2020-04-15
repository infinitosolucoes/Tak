import 'dart:async';

import 'package:tak/Objects/Company.dart';

class CompanyController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  Company _company;

  bool _autovalidate = false;     // Controle de validação do formulário
  bool _editMode = false;         // Controle de permissão de edição do formulário

  void getCompany(){
    this._company = company;
    this._streamController.add(this._company);
  }

  void dispose(){
    this._streamController.close(); 
  }

  bool getAutoValidate() => this._autovalidate;

  void setAutoValidate(bool value){
    this._autovalidate = value;
    this._streamController.add(this._autovalidate);
  }

  bool getEditMode() => this._editMode;

  void setEditMode(bool value){
    this._editMode = value;
    this._streamController.add(this._editMode);
  }

  // Getters do Formulário
  String getName() => this._company.name;
  String getCNPJ() => this._company.cnpj;
  String getPhoneNumber() => this._company.phoneNumber;
  String getEmail() => this._company.email;
  String getPassword() => this._company.password;
}