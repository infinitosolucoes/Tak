import 'dart:async';

class MethodPaymentController{
  int _method = 1;

  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da SalePage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  void setMethod(int method){
    this._method = method;
    this._streamController.add(this._method);
  }

  int getMethod() => this._method;

}