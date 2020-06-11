// Função de validação do CNPJ
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> cnpjValidator(String value, String before) async{
  if(value.length < 14){
    return 'Precisa de 14 dígitos';
  }else if(value == ('0'*14)){
    return 'CNPJ Inválido';
  }else if((await _existsCNPJ(value)) && (value != before)){
    return 'CNPJ já cadastrado';
  }
  List<int> weight1 = [5,4,3,2,9,8,7,6,5,4,3,2];
  List<int> weight2 = [6,5,4,3,2,9,8,7,6,5,4,3,2];
  String vd = '';

  String s = _calculateVD(value,weight1,vd);
  if(s == null){return 'CNPJ Inválido';}
  vd = vd + s;
  s = _calculateVD(value,weight2,vd);
  if(s == null){return 'CNPJ Inválido';}
  vd = vd + s;

  if(int.parse(vd) == int.parse(value.substring((value.length - 2),value.length))){
    return null;
  }else{
    return 'CNPJ Inválido';
  }
  
}

// Calculadora dos dígitos verificadores do CNPJ
String _calculateVD(String cnpj, List<int> weight, String vd){
  int counter = 0;
  for(int i = 0; i < weight.length; i++){
    int digit;
    if((vd != '') && (i == (weight.length - 1))){
      digit = int.tryParse(vd);
    }else{
      digit = int.tryParse(cnpj[i]);
    }
    if(digit == null){return null;}
    counter += digit * weight[i];
  }
  counter %= 11;
  if(counter >= 2){
    return (11-counter).toString();
  }else{
    return (0).toString();
  }
}

Future<bool> _existsCNPJ(String value) async{
  final Firestore firestore = Firestore.instance;
  //List<bool> results = [];

  final QuerySnapshot snapshot = await firestore.collection("companies").getDocuments();
  final List<DocumentSnapshot> documents = snapshot.documents; 

  for(int i = 0; i < documents.length; i++){
    Map<String, dynamic> data = documents[i].data;
    if(data['cnpj'] == value){
      return true;
    }
  }

 // try{
    // firestore.collection("companies").getDocuments().then(
    //   (querySnapshot){
    //     querySnapshot.documents.forEach(
    //       (element) {
    //         if(element.data['cnpj'] == value){
    //           results.add(true);
    //         }else{
    //           results.add(false);
    //         }
    //       }
    //     );
    //   }
    // );
  // }catch(e){
  //   print(e.toString);
  //   return null;
  // }

  //if(results.contains(true)){return true;}
  return false;
}
