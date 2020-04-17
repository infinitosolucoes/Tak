import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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

  IconData getIcon() => (this._editMode)? MdiIcons.contentSave : MdiIcons.leadPencil;

  String _calculateVD(String cnpj, List<int> weight, String vd){
    int counter = 0;
    for(int i = 0; i < weight.length; i++){
      if((vd != '') && (i == (weight.length - 1))){
        counter += int.parse(vd) * weight[i];
      }else{
        counter += int.parse(cnpj[i]) * weight[i];
      }
    }
    counter %= 11;
    if(counter >= 2){
      return (11-counter).toString();
    }else{
      return (0).toString();
    }
  }

  // Getters do Formulário
  String getName() => this._company.name;
  String getCNPJ() => this._company.cnpj;
  String getPhoneNumber() => this._company.phoneNumber;
  String getEmail() => this._company.email;
  String getPassword() => this._company.password;

  // Setters do Formulário
  void setName(String value) {
    this._company.name = value;
    this._streamController.add(this._company);
  } 
  void setCNPJ(String value) {
    this._company.cnpj = value;
    this._streamController.add(this._company);
  } 
  void setPhoneNumber(String value) {
    this._company.phoneNumber = value;
    this._streamController.add(this._company);
  } 
  void setEmail(String value) {
    this._company.email = value;
    this._streamController.add(this._company);
  } 
  void setPassword(String value) {
    this._company.password = value;
    this._streamController.add(this._company);
  } 


  // Validações do formulário               
  String nameValidator(String value) => (value.length >= 10)? null : 'Mínimo de 10 caracteres';

  String cnpjValidator(String value){
    if(value.length < 14){
      return 'Precisa de 14 dígitos';
    }else if(value == ('0'*14)){
      return 'CNPJ Inválido';
    } else{
      List<int> weight1 = [5,4,3,2,9,8,7,6,5,4,3,2];
      List<int> weight2 = [6,5,4,3,2,9,8,7,6,5,4,3,2];
      String vd = '';

      vd = vd + this._calculateVD(value,weight1,vd);
      vd = vd + this._calculateVD(value,weight2,vd);
      // int counter = 0;
      // for(int i = 0; i < weight1.length; i++){
      //     counter += int.parse(value[i]) * weight1[i];
      // } 
      // counter %= 11;
      // if(counter >= 2){
      //   vd = vd + (11-counter).toString();
      // }else{
      //   vd = vd + (counter).toString();
      // }
      
      // counter = 0;
      // for(int i = 0; i < weight2.length; i++){
      //   if(i == (weight2.length - 1)){
      //     counter += int.parse(vd) * weight2[i];
      //   }else{
      //     counter += int.parse(value[i]) * weight2[i];
      //   }
      // }
      
      // counter %= 11;
      // if(counter >= 2){
      //   vd = vd + (11-counter).toString();
      // }else{
      //   vd = vd + (counter).toString();
      // }
      
      if(int.parse(vd) == int.parse(value.substring((value.length - 2),value.length))){
        return null;
      }else{
        return 'CNPJ Inválido';
      }
    }
  }

  String phoneValidator(String value){
    if(value.length < 11){
      return 'Precisa ter 11 dígitos';
    }else{
      List ddd = [11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 24, 27, 28, 31, 32, 33, 34, 35, 37, 38, 41, 42, 43, 44, 45, 46, 47, 48, 49, 51, 53, 54, 55, 61, 62, 63, 64, 65, 66, 67, 68, 69, 71, 73, 74, 75, 77, 79, 81, 82, 83, 84, 85, 86, 87, 88, 89, 91, 92, 93, 94, 95, 96, 97, 98, 99];
      String s = value[0]+value[1];
      int n = int.parse(s);
      if(ddd.lastIndexOf(n) != -1){
        return null;
      }else{
        return 'DDD inválido';
      }
    }
  }
  String emailValidator(String value){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if(!regex.hasMatch(value)){
      return 'Email inválido';
    }
    return null;
  }
  String passwordValidator(String value) => (value.length >= 8)? null : 'Mínimo de 8 caracteres';
}