import 'package:tak/Objects/SaleItem.dart';

class Sale{
  String id;
  String date;
  double total;
  List<SaleItem> items;
  int methodPayment;      // 1 - Representa Dinheiro, 2 - Repreenta Cartão de Débito e 3 - Cartão de Crédito
  String invoice;

  Sale({
    this.id, this.date, this.total,
    this.items, this.methodPayment, this.invoice
  });

  Map saleMap(){
    return {
      "id": this.id,
      "date": this.date,
      "total": this.total,
      "items": this._convertListSaleItems(),
      "methodPayment": this.methodPayment,
      "invoice": this.invoice
    };
  }

  List<Map> _convertListSaleItems(){
    return List.generate(
      this.items.length,
      (int index) => this.items[index].saleItemMap()
    );
  }

  String getMethodPayment(){ 
    switch(this.methodPayment){
      case 1:
        return '1 - Dinheiro';
      
      case 2:
        return '2 - Cartão de Débito';
      
      case 3:
        return '3 - Cartão de Crédito';
      
      default:
        return '';
    }
  }
  
  @override
  String toString() => '\nNova Venda:\nID: '+this.id+'\nData: '+this.date+
                       '\nTotal: '+this.total.toString()+'\nTotal de Itens: '+this.items.length.toString()+
                       '\nMétodo: '+this.methodPayment.toString();
}