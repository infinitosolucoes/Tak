import 'package:tak/Objects/Address.dart';

class Company{
  String cnpj;
  String img;
  String name;
  String email;
  String phoneNumber; 
  Address address;
 

  Company({this.cnpj, this.img, this.name, this.address, this.email, this.phoneNumber});

  Company.newCompany(String email): this(
    cnpj: "",
    img: null,
    name: "",
    address: new Address.newAddress(),
    email: email,
    phoneNumber: "",
  );

  Company.fromJson(Map<String, dynamic> json): this(
    cnpj: json['cnpj'],
    img: json['img'],
    name: json['name'],
    address: new Address.fromJson(json['address']),
    email: json['email'],
    phoneNumber: json['phoneNumber'],

  );

  bool isEmpty(){
    if(
      (cnpj == "") &&
      (img == null) &&
      (name == "") &&
      (address.isEmpty()) &&
      (phoneNumber == "")
      
    ){
      return true;
    }
    return false;
  }

  Map<String,dynamic> toJson()
  => {
    'cnpj': this.cnpj,
    'img': this.img,
    'name': this.name,
    'email': this.email,
    'phoneNumber': this.phoneNumber,
    'address': this.address.toJson(),
  };
  
}
// objeto teste
Company company;