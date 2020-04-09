import 'package:tak/Objects/SaleItem.dart';

class Sale{
  String id;
  String date;
  double total;
  List<SaleItem> items;
  int methodPayment;

  Sale({
    this.id, this.date, this.total,
    this.items, this.methodPayment
  });
}