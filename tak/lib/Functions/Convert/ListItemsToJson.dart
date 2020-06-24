import 'package:tak/Objects/Item.dart';

List<Map<String,dynamic>> convertListItemsToJson(List<Item> items)
  => List.generate(
    items.length,
    (int index) => items[index].toJson()
);