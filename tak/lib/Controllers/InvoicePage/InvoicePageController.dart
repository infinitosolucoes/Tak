import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:tak/Objects/Sale.dart';
import 'package:tak/Objects/Company.dart';
import 'package:tak/Functions/MoneyText.dart' as MT;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

class InvoicePageController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da InvoicePage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  Sale _sale;
  

  final Firestore firestore = Firestore.instance;

  set sale(Sale sale){
    this._sale = sale;
    this._streamController.add(this._sale);
  }

  Future<bool> finalizeSale() async {
    try{ 
      company.sales.insert(0, this._sale);
      final user = await FirebaseAuth.instance.currentUser();

      this.firestore.collection("companies").document(user.email).updateData({'sales': company.convertListSaleToJson()}).then((_) {print("Salvado com sucesso");});
      this._streamController.add(company);
      print(this._sale.toString());
      return true;
  
    }catch(e){
      return false;
    }
  }

  Future<void> sendEmail() async{
    try{
      
      Uint8List invoiceBytes = base64Decode(this._sale.invoice);

      final Directory directory = await getTemporaryDirectory();
      final String path = directory.path;
      print(path);
      final File file = File('$path/Recibo.pdf');
      file.writeAsBytes(invoiceBytes);

      final Email email = Email(
        isHTML: false,
        subject: 'Recibo de ${company.name}',
        recipients: [],   
        attachmentPaths: [file.path],
      );

      await FlutterEmailSender.send(email);
      

    //  return true;
    }catch(e){
      print(e.toString());
     // return false;
    }
  }

  Future<Uint8List> generateInvoice(PdfPageFormat pageFormat) async {
    if(this._sale.invoice != null){
      Uint8List invoiceBytes = base64Decode(this._sale.invoice);
      return invoiceBytes;
    }

    final invoice = pw.Document();  // Crio o documento PDF da Nota Fiscal

    // Crio uma página
    invoice.addPage(
      pw.MultiPage(
        header: this._buildHeader,
        footer: this._buildFooter,

        build: (context) => [
          pw.SizedBox(height: 15),
          pw.Text('Código da Venda: ${this._sale.id}', style: pw.TextStyle(color: PdfColors.blueAccent, fontSize: 20)),
          pw.SizedBox(height: 5),
          this._generateTable(context),
          pw.SizedBox(height: 15),
          this._generateTotal(context),
        ]
      )
    );

    Uint8List invoiceBytes = invoice.save();  // Salvo o documento

    String base64Invoice = base64Encode(invoiceBytes);  // Converto para String de base 64
    this._sale.invoice = base64Invoice;                 // Salvo no objeto Sale
    
    this._streamController.add(this._sale);

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
            pw.Text('${company.name}, CNPJ: ${company.cnpj}, Tel.: ${company.phoneNumber}'),
            
          ]
        ),
        pw.SizedBox(height: 4),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text('Endereço: ${company.address.location}, ${company.address.houseNumber}, ${company.address.district}, ${company.address.city}, ${company.address.fu}.'),
            
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
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerHeight: 25,
      cellHeight: 40,

      // Alinhamento de cada célula
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },

      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: PdfColors.blueAccent,
      ),

      headerStyle: pw.TextStyle(
        color: PdfColors.white,
        fontWeight: pw.FontWeight.bold
      ),

      
      
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: PdfColors.blueAccent,
          width: .5,
        ),
      ),

      // Cabeçalho da Tabela
      headers: List<String>.generate(
        headers.length,
        (col) => headers[col],
      ),

      // Conteúdo da Tabela
      data: List<List<String>>.generate(
        this._sale.items.length,
        (row) => List<String>.generate(
          headers.length,
          (col) => this._sale.items[row].getValue(col),
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
            pw.Text(MT.moneyText(this._sale.total))//'R\$ ${this._sale.total.toString().replaceAll('.',',')}'),
          ]
        ),
        pw.SizedBox(height: 3),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Método de Pagamento:'),
            pw.Text(this._sale.getMethodPayment()),
          ]
        ),
        pw.SizedBox(height: 3),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Troco:'),
            pw.Text('R\$ 0,00'),
          ]
        ),
      ]
    );
  }


}
