import 'package:flutter/material.dart';
import 'package:tak/Controllers/ItemsPageController/ItemsPageController.dart';
import 'package:tak/Theme/theme.dart';
import 'package:tak/Objects/Item.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();

}

class _ItemsPageState extends State<ItemsPage>{
  final ItemsPageController _controller = ItemsPageController();

  void dispose(){
    this._controller.close;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // Altura da Tela
    double height = MediaQuery.of(context).size.height;

    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primary_color,
            centerTitle: true,
            title: Text('Itens', style: app_bar),
          ),
          backgroundColor: background_color,
          body: ListView.separated(
            itemCount:  this._controller.len(),
            separatorBuilder: (context, index) => divider,
            itemBuilder: (context, index){
              Item item = this._controller.getItem(index);
              return ListTile(
                title: Text(item.name, style: title_item),
                subtitle: Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Text('R\$ ' + item.price.toString().replaceAll('.',','), style: subtitle_item),
                ),
                trailing: IconButton(
                  icon: Icon(MdiIcons.closeCircleOutline, size: (height*0.05), color: danger_color),
                  onPressed: (){
                    this._controller.removeItem(index);
                  },
                )
              );
            },

          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primary_color,
            child: Icon(Icons.add, size: (height*0.06)),
            onPressed: () async{
              final item = await Navigator.pushNamed(context, '/listItems/createItem');
              if(item != null){
                this._controller.addItem(item);
              }
              
            }
          )
        );
      }
    ); 
  }
}