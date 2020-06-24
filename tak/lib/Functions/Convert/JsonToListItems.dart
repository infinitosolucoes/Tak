import 'package:tak/Objects/Item.dart';

List<Item> jsonToListItems(Map<String,dynamic> json) 
  => List.generate(
    json['items'].length,
    (int index) => Item.fromJson(json['items'][index])
);