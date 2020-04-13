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
  new Item(id: '0', name: 'Lorem Ipsum', price: 5.99),
  new Item(id: '1', name: 'Lorem Ipsum', price: 5.99),
  new Item(id: '2', name: 'Lorem Ipsum', price: 5.99),
  new Item(id: '3', name: 'Lorem Ipsum', price: 5.99),
  new Item(id: '4', name: 'Lorem Ipsum', price: 5.99),
  new Item(id: '5', name: 'Lorem Ipsum', price: 5.99),
];