import 'package:tak/Objects/Sale.dart';

List<Map<String,dynamic>> convertListSaleToJson(List<Sale> sales)
  => List.generate(
    sales.length,
    (int index) => sales[index].toJson()
);