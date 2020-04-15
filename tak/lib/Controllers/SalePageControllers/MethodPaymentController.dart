import 'dart:async';

class MethodPaymentController{
  int _method = 1;

  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void setMethod(int method){
    this._method = method;
    this._streamController.add(this._method);
  }

  int getMethod() => this._method;

  void dispose(){
    this._streamController.close();
  }
}