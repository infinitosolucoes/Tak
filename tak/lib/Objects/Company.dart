import 'package:tak/Objects/Item.dart';
import 'package:tak/Objects/Sale.dart';

class Company{
  String cnpj;
  String img;
  String name;
  String email;
  String password;
  String phoneNumber; 
  bool type;        // Determna se é comércio(true) ou serviço(false)
  List<Sale> sales;
  List<Item> items;

  Company({this.cnpj, this.img, this.name, this.type, this.email, this.password, this.phoneNumber, this.sales, this.items});

}
// objeto teste
Company company = new Company(
  cnpj: '0000000000', img: null, name: 'Pastel do Zé', type: true,
  email: 'pasteldoze@ze.com', password: '123456', phoneNumber: '22999236521',
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