class Address{
  String cep;
  String location;
  String district;
  String city;
  String fu;
  String houseNumber;

  Address({
    this.cep, this.location, this.district , this.houseNumber,
    this.city, this.fu
  });

  Address.newAddress(): this(
    cep: "",
    location: "",
    district: "",
    city: "",
    fu: "",
    houseNumber: ""
  );

  Address.fromJson(Map<String, dynamic> json): this(
    cep: json['cep'],
    location: json['location'],
    district: json['district'],
    city: json['city'],
    fu: json['fu'],
    houseNumber: json['houseNumber']
  );

  Map<String,dynamic> toJson()
    => {
      'cep': this.cep,
      'location': this.location,
     'district': this.district,
      'city': this.city,
      'fu': this.fu,
      'houseNumber': this.houseNumber
    };
  
}