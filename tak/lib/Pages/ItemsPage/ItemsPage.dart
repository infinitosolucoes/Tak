import 'package:flutter/material.dart';
import 'package:tak/Theme/theme.dart';
import 'package:tak/Objects/Item.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();

}

class _ItemsPageState extends State<ItemsPage>{
  @override
  Widget build(BuildContext context) {
    // Tamanho da Tela
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        centerTitle: true,
        title: Text('Itens', style: app_bar),
      ),
      backgroundColor: background_color,
      body: ListView.separated(
        itemCount:  items.length,
        separatorBuilder: (context, index){
          return Divider(
            height: 1,
            color: decoration_color,
          );
        },
        itemBuilder: (context, index){
          return ListTile(
            title: Text(items[index].name, style: title_item),
            subtitle: Text('R\$ ' + items[index].price.toString().replaceAll('.',','), style: subtitle_item),
            trailing: IconButton(
              icon: Icon(MdiIcons.closeCircleOutline, size: (height*0.05), color: danger_color),
              onPressed: (){
                setState(() {
                  items.removeAt(index);
                });
              },
            )
          );
        },

      ),
    );
  }

}