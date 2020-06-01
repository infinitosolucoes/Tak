import 'package:flutter/material.dart';
import 'package:tak/Controllers/InvoicePage/InvoicePageController.dart';
import 'package:tak/Objects/Sale.dart';
import 'package:tak/Theme/theme.dart';
import 'package:printing/printing.dart';

class InvoicePage extends StatefulWidget {

  final Sale sale;

  InvoicePage({Key key, @required this.sale}) : super(key: key);

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final InvoicePageController _controller = InvoicePageController();

  @override
  void initState(){
    this._controller.sale = widget.sale;
    super.initState();
  }

  @override
  void dispose(){
    this._controller.close;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        centerTitle: true,
        title: Text('Recibo', style: app_bar),

        actions: <Widget>[

          Visibility(
            visible: (widget.sale.invoice == null),
            child: IconButton(
              icon: Icon(Icons.save, color: background_color),
              onPressed: () async {
                if(await this._controller.finalizeSale()){
                  Navigator.pushNamedAndRemoveUntil(context,'/', (Route<dynamic> route) => false);
                }
              },
            ),
          ),

          IconButton(
            icon: Icon(Icons.send, color: background_color),
            onPressed: () async{
              if(await this._controller.sendEmail()){
                Navigator.pushNamedAndRemoveUntil(context,'/', (Route<dynamic> route) => false);
              }
            },
          )
          
        ],
        
      ),
      backgroundColor: background_color,

      body: PdfPreview(
        maxPageWidth: 600,
        build: this._controller.generateInvoice,
        allowPrinting: false,
        allowSharing: false,
        canChangePageFormat: false,
      ),
    );
  }
}