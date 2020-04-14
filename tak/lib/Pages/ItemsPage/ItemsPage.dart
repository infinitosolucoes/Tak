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
    // Altura da Tela
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        centerTitle: true,
        title: Text('Itens', style: app_bar),
      ),
      backgroundColor: background_color,
      body: ListView.separated(
        itemCount:  items.length,
        separatorBuilder: (context, index) => divider,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(items[index].name, style: title_item),
            subtitle: Container(
              padding: EdgeInsets.only(top: 5),
              child: Text('R\$ ' + items[index].price.toString().replaceAll('.',','), style: subtitle_item),
            ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary_color,
        child: Icon(Icons.add, size: (height*0.06)),
        onPressed: (){}
      )
    );
  }

}