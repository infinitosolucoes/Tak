class Address{
 
  String location;
  String district;
  String city;
  String fu;
  String houseNumber;

  Address({
    this.location, this.district , this.houseNumber,
    this.city, this.fu
  });

  Address.newAddress(): this(
    location: "",
    district: "",
    city: "",
    fu: "AC",
    houseNumber: ""
  );

  Address.fromJson(Map<String, dynamic> json): this(
    
    location: json['location'],
    district: json['district'],
    city: json['city'],
    fu: json['fu'],
    houseNumber: json['houseNumber']
  );

  bool isEmpty(){
    if(
      (location == "") &&
      (district == "") &&
      (city == "") &&
      (houseNumber == "")
    ){
      return true;
    }
    return false;
  }

  Map<String,dynamic> toJson()
    => {
      'location': this.location,
     'district': this.district,
      'city': this.city,
      'fu': this.fu,
      'houseNumber': this.houseNumber
    };
  
}