import 'package:tak/Objects/Item.dart';

class SaleItem{
  Item item;
  int amount;
  
  SaleItem({this.item, this.amount});

  Map saleItemMap(){
    return {
      "item": this.item.itemMap(),
      "amount": this.amount
    };
  }

  double calculateTotal() => this.item.price * this.amount;

  String getValue(int index){
    switch (index) {
      case 0:
        return this.item.id;
        
      case 1:
        return this.item.name;

      case 2:
        return this.amount.toString();
      
      case 3: 
        return ('R\$ ' + this.item.price.toString().replaceAll('.',','));

      case 4:
        return ('R\$ ' + this.calculateTotal().toString().replaceAll('.',','));
      
      default:
        return '';
    }
  }
}