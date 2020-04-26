import 'package:tak/Objects/SaleItem.dart';

class Sale{
  String id;
  String date;
  double total;
  List<SaleItem> items;
  int methodPayment;      // 1 - Representa Dinheiro, 2 - Repreenta Cartão de Débito e 3 - Cartão de Crédito

  Sale({
    this.id, this.date, this.total,
    this.items, this.methodPayment
  });
  
  @override
  String toString() => '\nNova Venda:\nID: '+this.id+'\nData: '+this.date+
                       '\nTotal: '+this.total.toString()+'\nTotal de Itens: '+this.items.length.toString()+
                       '\nMétodo: '+this.methodPayment.toString();
}