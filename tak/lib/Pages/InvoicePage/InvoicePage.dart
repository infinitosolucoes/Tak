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
    this._controller.showAd((widget.sale.invoice == null));
    super.initState();
  }

  @override
  void dispose(){
    this._controller.close;
    this._controller.disposeAd();
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
                if(this._controller.invoice != null){
                  if(await this._controller.finalizeSale()){
                    Navigator.pushNamedAndRemoveUntil(context,'/', (Route<dynamic> route) => false);
                  }
                }else{
                  showDialog(
                    context: context, 
                    barrierDismissible: false, 
                    builder: (BuildContext context) {
                      return AlertDialog(
                      
                        content: Text('Erro: O Recibo ainda está sendo gerado.'),
                              
                        
                        actions: <Widget>[
                          FlatButton(
                            child: Text('FECHAR'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }
                  );
                }
                
              },
            ),
          ),

          IconButton(
            icon: Icon(Icons.send, color: background_color),
            onPressed:() async {
              if(this._controller.invoice != null){
                await this._controller.sendEmail();
              }else{
                showDialog(
                    context: context, 
                    barrierDismissible: false, 
                    builder: (BuildContext context) {
                      return AlertDialog(
                      
                        content: Text('Erro: O Recibo ainda está sendo gerado.'),
                              
                        
                        actions: <Widget>[
                          FlatButton(
                            child: Text('FECHAR'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }
                  );
              }
            }
                
      
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
