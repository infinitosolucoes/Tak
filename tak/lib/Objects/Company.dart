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
    img: "",
    name: "",
    address: new Address.newAddress(),
    email: email,
    phoneNumber: "",
    sales: [],
    items: []
  );

  Map<String,dynamic> companyMap(){
    return {
      'cnpj': this.cnpj,
      'img': this.img,
      'name': this.name,
      'email': this.email,
      'phoneNumber': this.phoneNumber,
      'address': this.address.addressMap(),
      'sales': this._convertListSale(),
      'items': this._convertListItems()
    };
  }

  List<Map<String,dynamic>> _convertListItems(){
    return List.generate(
      this.items.length,
      (int index) => this.items[index].itemMap()
    );
  }

  List<Map<String,dynamic>> _convertListSale(){
    return List.generate(
      this.sales.length,
      (int index) => this.sales[index].saleMap()
    );
  }
}
// objeto teste
Company company = new Company(
  cnpj: '50306471000109', img: null, name: 'Pastel do Zé', 
  address: Address(cep: '28994642', location: 'Rua Francisca Maria de Oliveira', city: 'Saquarema', district: 'Bacaxá', houseNumber: '23', fu: 'RJ',),
  email: 'pasteldoze@ze.com', phoneNumber: '22999236521',
  sales: [
    new Sale(date: '2020-02-14', methodPayment: 3, total: 100.00),
    new Sale(date: '2020-04-01', methodPayment: 2, total: 30.00),
    new Sale(date: '2020-04-04', methodPayment: 1, total: 22.64),
  ], 
  items: [
    new Item(id: '0', name: 'Lorem Ipsum', price: 5.99),
    new Item(id: '1', name: 'Lorem Ipsum', price: 5.99),
    new Item(id: '2', name: 'Lorem Ipsum', price: 5.99),
    new Item(id: '3', name: 'Lorem Ipsum', price: 5.99),
    new Item(id: '4', name: 'Lorem Ipsum', price: 5.99),
    new Item(id: '5', name: 'Lorem Ipsum', price: 5.99),
  ]
);