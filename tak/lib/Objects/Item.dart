class Item{
  String id;
  String img;
  String name;
  bool type;                  // Este booleano é pra saber se o item é um produto ou serviço
  double price;
  int guarantee;              // Se for serviço deve inserir a quantidade de dias de garantia

  Item({
    this.id, this.name, this.img, this.type,
    this.price, this.guarantee
  });
}
