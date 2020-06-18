import 'dart:async';

class CounterController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;                   // Entrada de dados da AddItemPage
  Stream get output => _streamController.stream;              // Saída de dados do Controller
  Future get close => _streamController.close();              // Fechamento da Stream

  int amountView = 1;

  void increaseAmount(){
    this.amountView++;
    this._streamController.add(this.amountView);
  }

  void decrementAmount(){
    if(this.amountView > 1){
      this.amountView--;
      this._streamController.add(this.amountView);
    }
  }

  void reset(){
    if(this.amountView != 1){
      this.amountView = 1;
    }
  }
}