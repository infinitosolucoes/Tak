class Item{
  String id;
  String name;
  bool type;                  // Este booleano é pra saber se o item é um produto ou serviço
  double price;
  int guarantee;

  Item({
    this.id, this.name, this.type,
    this.price, this.guarantee
  });
}
