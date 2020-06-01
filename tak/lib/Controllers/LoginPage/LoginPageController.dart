import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';

import 'package:tak/Objects/Company.dart';

class LoginPageController{
  final StreamController _streamController = new StreamController.broadcast();
  
  Sink get input => _streamController.sink;                   // Entrada de dados da LoginPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final Firestore firestore = Firestore.instance;


  Future<String> signInWithGoogle() async{
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
    
    if(doc == null){
      company = new Company.newCompany(user.email);
      Map<String,dynamic> json = company.toJson();
    
      await this.firestore.collection("companies").document(user.email).setData(json);
    }else{
      Map<String, dynamic> json = doc.data; 
      company = Company.fromJson(json);
      print(company.email);
    }

    return 'signInWithGoogle succeeded: $user';
  }
}
