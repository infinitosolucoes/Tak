import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tak/Functions/Convert/Convert.dart' as Convert;
import 'package:tak/Objects/Sale.dart';

Future<List<Sale>> loadItems(Firestore firestore) async {
  final user = await FirebaseAuth.instance.currentUser();
  DocumentSnapshot doc = await firestore.collection("companies").document(user.email).get();
  return Convert.jsonToListSales(doc.data['sales']);
}