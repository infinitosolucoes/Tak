import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';

import 'package:tak/Dict/Dictionary.dart';
import 'package:tak/Objects/Company.dart';
import 'package:tak/Functions/Dialog.dart' as Dialog;

class LoginPageController{
  final StreamController _streamController = new StreamController.broadcast();
  
  Sink get input => _streamController.sink;                   // Entrada de dados da LoginPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final Firestore firestore = Firestore.instance;

  Future<void> login(BuildContext context) async{
    String result = await this._signInWithGoogle();
    if(result != null){
      Navigator.pushNamedAndRemoveUntil(context,routes['home'], (Route<dynamic> route) => false);
    }else{
      Dialog.dialog(context, phrases['connectionError']);
      print('Deu Ruim');
    }
  }
  Future<String> _signInWithGoogle() async{
    try{
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult = await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      
      
      print('signInWithGoogle succeeded: ${user.toString()}');

      DocumentSnapshot doc = await this.firestore.collection("companies").document(user.email).get();
      
      if((doc == null) || (!doc.exists)){
        company = new Company.newCompany(user.email);
        //Map<String,dynamic> json = company.toJson();
        Map<String,dynamic> json = {
          'cnpj': "",
          'img': null,
          'name': "",
          'address': {
            'location': "",
            'district': "",
            'city': "",
            'fu': "AC",
            'houseNumber': ""
          },
          'email': user.email,
          'phoneNumber': "",
          'sales': [],
          'items': []
        };
        await this.firestore.collection("companies").document(user.email).setData(json);
      //}
      }else{
        Map<String, dynamic> json = doc.data; 
        company = Company.fromJson(json);
        print(company.email);
      }

      return 'signInWithGoogle succeeded: $user';
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  
}
