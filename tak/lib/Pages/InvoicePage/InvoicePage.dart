import 'package:flutter/material.dart';
import 'package:tak/Controllers/InvoicePageController/InvoicePageController.dart';
import 'package:tak/Objects/Sale.dart';
import 'package:tak/Theme/theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
        
      ),
      backgroundColor: background_color,

      body: PdfPreview(
        maxPageWidth: 700,
        build: this._controller.generateInvoice(),
        
        //onPrinted: _showPrintedToast,
        //onShared: _showSharedToast,
      ),
    );
  }
}