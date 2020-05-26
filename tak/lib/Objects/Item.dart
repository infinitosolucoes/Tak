class Item{
  String id;
  String img;
  String name;
  double price;

  Item({
    this.id, this.name, this.img, this.price
  });

  Map itemMap(){
    return {
      id: this.id,
      img: this.name,
      name: this.img,
      price: this.price
    };
  }
}
