import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tak/Objects/Company.dart';

class CompanyController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da CompanyPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream


  bool _autovalidate = false;               // Controle de validação do formulário
  bool _editMode = false;                   // Controle de permissão de edição do formulário
  final formKey = GlobalKey<FormState>();

  File _image;

  Future setImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    this._image = image;
    if(this._image != null){
      List<int> imageBytes = this._image.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      company.img = base64Image;
      print('\n Imagem: '+company.img+'\n');
      this._streamController.add(company);
    }
    
  }
  
  void getCompany(){
    company = company;
    this._streamController.add(company);
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

  ImageProvider getImage(){ 
    if (company.img  == null){ 
      return AssetImage('images/profile.png');
    }else{ 
      Uint8List image = base64Decode(company.img);
      return MemoryImage(image);
    }
  }

  // Getters do Formulário
  String getName() => company.name;
  String getCNPJ() => company.cnpj;
  String getPhoneNumber() => company.phoneNumber;
  String getEmail() => company.email;
  String getPassword() => company.password;

  // Setters do Formulário
  void setName(String value) {
    company.name = value;
    this._streamController.add(company);
  } 
  void setCNPJ(String value) {
    company.cnpj = value;
    this._streamController.add(company);
  } 
  void setPhoneNumber(String value) {
    company.phoneNumber = value;
    this._streamController.add(company);
  } 
  void setEmail(String value) {
    company.email = value;
    this._streamController.add(company);
  } 
  void setPassword(String value) {
    company.password = value;
    this._streamController.add(company);
  } 


  
  bool submit(){
    if(this.formKey.currentState.validate()){
      this.formKey.currentState.save();
      return true;
    }else{
      this.setAutoValidate(true);
      return false;
    }
  }
}
