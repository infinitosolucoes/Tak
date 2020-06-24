import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tak/Dict/Dictionary.dart';
import 'package:tak/Functions/ImagePicker.dart' as IMG;
import 'package:tak/Objects/Company.dart';
import 'package:tak/Functions/Validators/CNPJ.dart';
import 'package:tak/Functions/Dialog.dart' as Dialog;


class CompanyController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da CompanyPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream


  bool _autovalidate = false;               // Controle de validação do formulário
  bool _editMode = false;                   // Controle de permissão de edição do formulário
  final formKey = GlobalKey<FormState>();   // Chave para a validação do Formulário

  final GoogleSignIn googleSignIn = GoogleSignIn(); // Responsável para fazer o LogOut da Conta
  final Firestore firestore = Firestore.instance;   // Responsável para fazer a manipulação no BD do Firebase

  String _cnpjResult;               // Mostra o resultado de que o CNPJ é valido  
  String _cnpjValue = company.cnpj; // Valor atual do CNPJ no campo do Formulário

  // Lista dos estados brasileiros
  static List<String> _fus = ['AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'];

  Future buttonAction(BuildContext context)async {
    if(this.editMode){
      bool flag = await this._submit(context);
      this.editMode = !flag;
      
    }else{
      this.editMode = true;
    }
     this._streamController.add(this.editMode );
  }

  Future<bool> _submit(BuildContext context) async {
    this._cnpjResult = await cnpjValidator(this._cnpjValue, company.cnpj);
    this._streamController.add(this._cnpjResult);
    
    if(this.formKey.currentState.validate()){
      this.formKey.currentState.save();
      try{
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
      }catch(e){
        Dialog.dialog(context, phrases['connectionError']);
      }
      
      return true;
    }else{
      this._autovalidate = true;
      this._streamController.add(this._autovalidate);
      return false;
    }
  }
  
  Future<void> signOut(BuildContext context) async{
    try{
      await this.googleSignIn.signOut().whenComplete(() { 
        Navigator.pushNamedAndRemoveUntil(context,routes['login'], (Route<dynamic> route) => false);
      });
      print('Usuário saiu');
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> deleteCompany(BuildContext context) async{
    try{
      final user = await FirebaseAuth.instance.currentUser();
      await this.firestore.collection("companies").document(user.email).delete();
      print('Usuário deletado');
      this.signOut(context);
    }catch(e){
      print(e.toString());
    }
  }

  

  List<DropdownMenuItem<String>> _options = List.generate(
    _fus.length, (int index){
      return DropdownMenuItem<String>(
        child: Text(_fus[index]),
        value: _fus[index],
      );
    }
  );
  

  // Getters do Formulário
  bool get autoValidate => this._autovalidate;
  bool get editMode => this._editMode;

  IconData get icon => (this._editMode)? MdiIcons.contentSave : MdiIcons.leadPencil;
  List<DropdownMenuItem<String>> get options => (this._editMode)? this._options: null;
  
  String get cnpjResult => this._cnpjResult;
  
  ImageProvider get image { 
    if (company.img  == null){ 
      return AssetImage('images/profile.png');
    }else{ 
      Uint8List image = base64Decode(company.img);
      return MemoryImage(image);
    }
  }

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
  set cnpjValue(String value){
    this._cnpjValue = value;
    this._streamController.add(_cnpjValue);
  }

  Future setImage() async{
    String img = await IMG.imagePicker(200,200,70);
    if(img != null){
      company.img = img;
      this._streamController.add(company);
    }
    
  }

  set editMode(bool value){
    this._editMode = value;
    this._streamController.add(this._editMode);
  }

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
 
}
