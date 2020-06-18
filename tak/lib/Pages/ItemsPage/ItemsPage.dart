import 'package:flutter/material.dart';
import 'package:tak/Controllers/ItemsPage/ItemsPageController.dart';
import 'package:tak/Dict/Dictionary.dart';
import 'package:tak/Functions/Text/MoneyText.dart' as MT;
import 'package:tak/Theme/Theme.dart';
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
    // Tamanho da Tela
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primary_color,
            centerTitle: true,
            title: Text(phrases['items'], style: app_bar),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add, color: background_color, size: 30),
                onPressed: () async{await this._controller.add(context);},
              ),
              SizedBox(width: (width * 0.04),)
            ],
          ),

          backgroundColor: background_color,

          body: ListView.separated(
            itemCount:  this._controller.len(),
            separatorBuilder: (context, index) => divider,
            itemBuilder: (context, index){
              Item item = this._controller.getItem(index);
              return ListTile(
                leading: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.all(Radius.circular(10.0)) 
                  ),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: Ink.image(
                    image: this._controller.getImageItem(item),
                    fit: BoxFit.cover,
                    width: 50.0,
                    height: 50.0,
                    
                  ),
                ),
                title: Text(item.name, style: title_item),
                subtitle: Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(MT.moneyText(item.price), style: subtitle_item),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Botão para editar o item
                    IconButton(
                      icon: Icon(MdiIcons.pencil, size: (height*0.05), color: decoration_color),
                      onPressed: () async{await this._controller.edit(context, index, item);},
                    ),
                   
                    // Botão para deletar o item
                    IconButton(
                      icon: Icon(MdiIcons.closeCircleOutline, size: (height*0.05), color: danger_color),
                      onPressed: () async {await this._controller.delete(context, index);},
                    )
                  ],
                )
              );
            },

          ),
        );
      }
    ); 
  }
}
