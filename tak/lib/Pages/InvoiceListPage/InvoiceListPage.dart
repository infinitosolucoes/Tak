import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tak/Controllers/InvoiceListPage/InvoiceListPageController.dart';
import 'package:tak/Theme/Theme.dart';

class InvoiceListPage extends StatefulWidget {
  @override
  _InvoiceListPageState createState() => _InvoiceListPageState();
}

class _InvoiceListPageState extends State<InvoiceListPage> {
  final InvoiceListPageController _controller = new InvoiceListPageController();
  

  @override
  void initState(){
    this._controller.initialize();
    super.initState();
  }

  @override
  void dispose(){
    this._controller.close;
    super.dispose();
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
            title: Text('Recibos', style: app_bar),
            ),
          backgroundColor: background_color,

          body: ListView.separated(
            itemCount: this._controller.len(),
            itemBuilder: (context, index){
              return ListTile(
                leading: Icon(MdiIcons.receipt, color: primary_color, size: 40),
                title: Text(this._controller.title(index), style: title_item),

                onTap: (){
                  Navigator.pushNamed(context, "/invoice", arguments: this._controller.sale(index));
                },
              );
            }, 
            separatorBuilder: (context, index) => divider, 
            
          ),
        );
      },
    );
  }
}
