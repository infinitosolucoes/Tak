import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tak/Objects/Sale.dart';
import 'package:tak/Functions/Convert/Convert.dart' as Convert;

class InvoiceListPageController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da InvoiceListPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  Firestore _firestore = Firestore.instance;
 

  List<Sale> _sales;

  List<Sale> get sales => this._sales;

  int len() => this._sales.length;

  Sale sale(int index) => this._sales[index];

  String title(int index) => '${this._sales[index].id} - ${this._sales[index].date}';

  void initialize() async{
    final user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot doc = await this._firestore.collection("companies").document(user.email).get();
    this._sales = Convert.jsonToListSales(doc.data['sales']);
    this._streamController.add(this._sales);
  }
}