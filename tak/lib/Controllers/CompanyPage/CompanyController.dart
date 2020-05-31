import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final Firestore firestore = Firestore.instance;

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


  bool get autoValidate => this._autovalidate;


  bool get editMode => this._editMode;

  set editMode(bool value){
    this._editMode = value;
    this._streamController.add(this._editMode);
  }

  IconData get icon => (this._editMode)? MdiIcons.contentSave : MdiIcons.leadPencil;

  ImageProvider get image { 
    if (company.img  == null){ 
      return AssetImage('images/profile.png');
    }else{ 
      Uint8List image = base64Decode(company.img);
      return MemoryImage(image);
    }
  }


  static List<String> _fus = ['AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'];

  List<DropdownMenuItem<String>> _options = List.generate(
    _fus.length, (int index){
      return DropdownMenuItem<String>(
        child: Text(_fus[index]),
        value: _fus[index],
      );
    }
  );
  List<DropdownMenuItem<String>> get options => (this._editMode)? this._options: null;

  // Getters do Formulário
  String get name => company.name;
  String get cnpj => company.cnpj;
  String get phoneNumber => company.phoneNumber;
  String get email => company.email;
  

  String get location => company.address.location;
  String get houseNumber => company.address.houseNumber;
  String get district => company.address.district;
  String get city => company.address.city;
  String get fu => company.address.fu;

  // Setters do Formulário
  set name(String value) {
    company.name = value;
    this._streamController.add(company);
  } 
  set cnpj(String value) {
    company.cnpj = value;
    this._streamController.add(company);
  } 
  set phoneNumber(String value) {
    company.phoneNumber = value;
    this._streamController.add(company);
  } 
  
  set location(String value){
    company.address.location = value;
    this._streamController.add(company);
  }

  set houseNumber(String value){
    company.address.houseNumber = value;
    this._streamController.add(company);
  }

  set district(String value){
    company.address.district = value;
    this._streamController.add(company);
  }

  set city(String value){
    company.address.city = value;
    this._streamController.add(company);
  }

  set fu(String value){
    company.address.fu = value;
    this._streamController.add(company);
  }


  Future<bool> submit() async {
    if(this.formKey.currentState.validate()){
      this.formKey.currentState.save();
      final user = await FirebaseAuth.instance.currentUser();

      this.firestore.collection("companies").document(user.email).updateData(
        {
          'cnpj': company.cnpj,
          'img': company.img,
          'name': company.name,
          'email': company.email,
          'phoneNumber': company.phoneNumber,
          'address': company.address.toJson(),
        }).then((_) {print("Salvado com sucesso");});
      return true;
    }else{
      this._autovalidate = true;
      this._streamController.add(this._autovalidate);
      return false;
    }
  }

 
}
