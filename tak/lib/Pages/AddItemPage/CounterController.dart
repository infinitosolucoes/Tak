import 'dart:async';

class CounterController{
  final StreamController _streamController = new StreamController.broadcast();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;
  int amountView = 0;

  void increaseAmount(){
    this.amountView++;
    this._streamController.add(this.amountView);
  }

  void decrementAmount(){
    if(this.amountView > 0){
      this.amountView--;
      this._streamController.add(this.amountView);
    }
  }

  void reset(){
    if(this.amountView != 0){
      this.amountView = 0;
    }
  }

  void dispose(){
    this._streamController.close();
  }
}