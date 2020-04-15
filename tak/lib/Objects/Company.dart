import 'package:tak/Objects/Item.dart';
import 'package:tak/Objects/Sale.dart';

class Company{
  String cnpj;
  String name;
  String email;
  String password;
  String phoneNumber; 
  bool type;        // Determna se é comércio(true) ou serviço(false)
  List<Sale> sales;
  List<Item> items;

  Company({this.cnpj, this.name, this.type, this.email, this.password, this.phoneNumber, this.sales, this.items});

  void newSale(Sale sale){
    if(sale != null){
      this.sales.add(sale);
    }
  }

  void newItem(Item item){
    if(item != null){
      this.items.add(item);
    }
  }

  void removeItem(int index){
    this.items.removeAt(index);
  }

  void editCompany(String cnpj, String name, String email, String phoneNumber){
    this.cnpj = cnpj;
    this.name = name;
    this.email = email;
    this.phoneNumber = phoneNumber;
  }
}

Company company = new Company(
  cnpj: '0000000000', name: 'Pastel do Zé', type: true,
  email: 'pasteldoze@ze.com', password: '123456', phoneNumber: '+5522999236521',
  sales: [], items: []
);