import 'package:tak/Objects/Item.dart';
import 'package:tak/Functions/Text/MoneyText.dart' as MT;

class SaleItem{
  Item item;
  int amount;
  
  SaleItem({this.item, this.amount});

  SaleItem.fromJson(Map<String,dynamic> json): this(
    item: Item.fromJson(json['item']),
    amount: json['amount']
  );

  Map<String,dynamic> toJson()
  => {
    'item': this.item.toJson(),
    'amount': this.amount
  };
  

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
        return MT.moneyText(this.item.price);//('R\$ ' + this.item.price.toString().replaceAll('.',','));

      case 4:
        return MT.moneyText(this.calculateTotal());//('R\$ ' + this.calculateTotal().toString().replaceAll('.',','));
      
      default:
        return '';
    }
  }
}