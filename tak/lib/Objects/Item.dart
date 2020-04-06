class Item{
  String id;
  String name;
  bool type;
  double price;
  int guarantee;

  Item({
    this.id, this.name, this.type,
    this.price, this.guarantee
  });
}

List<Item> items = [
  new Item(name: 'Lorem Ipsum', price: 5.99),
  new Item(name: 'Lorem Ipsum', price: 5.99),
  new Item(name: 'Lorem Ipsum', price: 5.99),
  new Item(name: 'Lorem Ipsum', price: 5.99),
  new Item(name: 'Lorem Ipsum', price: 5.99),
  new Item(name: 'Lorem Ipsum', price: 5.99),
];