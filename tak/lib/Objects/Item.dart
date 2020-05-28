class Item{
  String id;
  String img;
  String name;
  double price;

  Item({
    this.id, this.name, this.img, this.price
  });

  Item.fromJson(Map<String, dynamic> json): this(
    id: json['id'],
    img: json['img'],
    name: json['name'],
    price: json['price']
  );  

  Map<String,dynamic> toJson()
    => {
      'id': this.id,
      'img': this.name,
      'name': this.img,
      'price': this.price
    };
  
}
