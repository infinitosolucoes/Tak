import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:tak/Objects/Sale.dart';
import 'package:tak/Objects/Company.dart';

class InvoicePageController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da CompanyPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  Sale _newSale;

  set newSale(Sale sale){
    this._newSale = sale;
    this._streamController.add(this._newSale);
  }

  bool finalizeSale(){
    try{ 
      company.sales.add(this._newSale);
      this._streamController.add(company);
      print(this._newSale.toString());
      return true;
  
    }catch(e){
      return false;
    }
  }

  Future<Uint8List> generateInvoice(PdfPageFormat pageFormat) async {
    final invoice = pw.Document();  // Crio o documento PDF da Nota Fiscal

    // Crio uma página
    invoice.addPage(
      pw.MultiPage(
        header: this._buildHeader,
        footer: this._buildFooter,

        build: (context) => [
          this._generateTable(context),
          this._generateTotal(context),
        ]
      )
    );

    Uint8List invoiceBytes = invoice.save();  // Salvo o documento

    String base64Invoice = base64Encode(invoiceBytes);  // Converto para String de base 64
    this._newSale.invoice = base64Invoice;                 // Salvo no objeto Sale
    
    this._streamController.add(this._newSale);

    return invoiceBytes;     // Envio os bytes a serem mostrado na InvoicePage
  }

  // Crio o cabeçalho da Nota Fiscal
  pw.Widget _buildHeader(pw.Context context){
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(company.name),
            pw.Text(company.cnpj),
            pw.Text(company.phoneNumber),
          ]
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(company.address.location),
            pw.Text(company.address.houseNumber),
            pw.Text(company.address.district),
            pw.Text(company.address.city),
            pw.Text(company.address.fu),
            pw.Text(company.address.cep)
          ]
        ),
      ]
    );
  }

  // Rodapé da Nota Fiscal
  pw.Widget _buildFooter(pw.Context context){
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text("DOCUMENTO NÃO FISCAL")
          ]
        ),
      ]
    );
  }

  pw.Widget _generateTable(pw.Context context){
    // Cabeçalho da Tabela
    const headers = [
      'Cód',
      'Nome',
      'Qtd',
      'Preço por Item',
      'Subtotal'
    ];

    return pw.Table.fromTextArray(
      headerHeight: 25,
      cellHeight: 40,

      // Alinhamento de cada célula
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },

      // Cabeçalho da Tabela
      headers: List<String>.generate(
        headers.length,
        (col) => headers[col],
      ),

      // Conteúdo da Tabela
      data: List<List<String>>.generate(
        this._newSale.items.length,
        (row) => List<String>.generate(
          headers.length,
          (col) => this._newSale.items[row].getValue(col),
        ),
      ),
      
    );
  }

  pw.Widget _generateTotal(pw.Context context){
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total:'),
            pw.Text('R\$ ' + this._newSale.total.toString().replaceAll('.',',')),
          ]
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Método de Pagamento:'),
            pw.Text(this._newSale.getMethodPayment()),
          ]
        )
      ]
    );
  }


}