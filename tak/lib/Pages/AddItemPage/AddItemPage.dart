import 'package:flutter/material.dart';
import 'package:tak/Objects/Item.dart';
import 'package:tak/Controllers/AddItemPage/Controllers.dart';
import 'package:tak/Theme/theme.dart';


class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {

  final AddItemController _controller = AddItemController();
  final CounterController _counterController = CounterController(); 

  void initState(){
    super.initState();
    this._controller.loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primary_color,
            centerTitle: true,
            title: Text('Adicionar Item', style: app_bar),
          ),

          backgroundColor: background_color,
          
          body: ListView.separated(
            itemCount: this._controller.len(),
            itemBuilder: (context, index){
              Item item = this._controller.getItem(index);
              return Container(
                padding: EdgeInsets.only(top: 3, bottom: 3),
                child: ListTile(
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
                  trailing: Text('R\$ ' +  item.price.toStringAsFixed(2).replaceAll('.', ','), style: subtotal_text),
                  onTap: (){          
                    this._controller.setItem(index); 
                    this._counterController.reset();
                    this.showSelectAmount();
                  },
                ),
              );
            }, 
            separatorBuilder: (context, index) => divider,
            
          ),          
        );
      }
    );
  }

  showSelectAmount(){
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (BuildContext context){
        return StreamBuilder(
          stream: this._counterController.output,
          builder: (context,snapshot){
            return Container(
              color: background_color,
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Informe a Quantidade: ', style: title_item,),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                        child: RaisedButton(
                          color: danger_color,
                          shape: shape,
                          child: Icon(Icons.remove, size: 30, color: background_color),
                          onPressed: this._counterController.decrementAmount,
                        ),
                      ),

                      Text(this._counterController.amountView.toString(), style: TextStyle(fontSize: 20),),
                      
                      SizedBox(
                        height: 50,
                        child: RaisedButton(
                          color: success_color,
                          shape: shape,
                          child: Icon(Icons.add, size: 30, color: background_color),
                          onPressed: this._counterController.increaseAmount,
                        ), 
                      ),
                      
                    ],   
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: RaisedButton(
                            color: primary_color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text('Confirmar', style: button_text,),
                            onPressed: (){
                              this._controller.setAmount(this._counterController.amountView);
                              Navigator.pop(context);
                              if(!this._controller.isNull()){
                                Navigator.pop(context,this._controller.getSaleItem());
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            );
          }
        );
      }
    );
  }

  void dispose(){
    this._controller.close;
    this._counterController.close;
    super.dispose();
  }


}