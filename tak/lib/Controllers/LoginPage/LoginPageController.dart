import 'dart:async';

class LoginPageController{
  final StreamController _streamController = new StreamController.broadcast();
  
  Sink get input => _streamController.sink;                   // Entrada de dados da LoginPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream
}