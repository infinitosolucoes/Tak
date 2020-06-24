import 'package:tak/Objects/Sale.dart';

List<Sale> jsonToListSales(Map<String,dynamic> json) 
  => List.generate(
    json['sales'].length,
    (int index) => Sale.fromJson(json['sales'][index])
);
