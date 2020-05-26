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

  Map addressMap(){
    return {
      cep: this.cep,
      location: this.location,
      district: this.district,
      city: this.city,
      fu: this.fu,
      houseNumber: this.houseNumber
    };
  }
}