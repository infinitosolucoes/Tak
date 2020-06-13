import 'package:tak/Objects/Address.dart';
import 'package:tak/Objects/Item.dart';
import 'package:tak/Objects/Sale.dart';

class Company{
  String cnpj;
  String img;
  String name;
  String email;
  String phoneNumber; 
  Address address;
  List<Sale> sales;
  List<Item> items;

  Company({this.cnpj, this.img, this.name, this.address, this.email, this.phoneNumber, this.sales, this.items});

  Company.newCompany(String email): this(
    cnpj: "",
    img: null,
    name: "",
    address: new Address.newAddress(),
    email: email,
    phoneNumber: "",
    sales: [],
    items: []
  );

  Company.fromJson(Map<String, dynamic> json): this(
    cnpj: json['cnpj'],
    img: json['img'],
    name: json['name'],
    address: new Address.fromJson(json['address']),
    email: json['email'],
    phoneNumber: json['phoneNumber'],

    sales: List.generate(
      json['sales'].length,
      (int index) => Sale.fromJson(json['sales'][index])
    ),

    items: List.generate(
      json['items'].length,
      (int index) => Item.fromJson(json['items'][index])
    )
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
    'sales': this.convertListSaleToJson(),
    'items': this.convertListItemsToJson()
  };
  

  List<Map<String,dynamic>> convertListItemsToJson()
  => List.generate(
    this.items.length,
    (int index) => this.items[index].toJson()
  );
  

  List<Map<String,dynamic>> convertListSaleToJson()
  => List.generate(
    this.sales.length,
    (int index) => this.sales[index].toJson()
  );
  
}
// objeto teste
Company company;