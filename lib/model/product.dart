class Product{
 final int? id;
 final String? name;
 final String? description;
 final String? price;

  Product({ this.id,this.name,this.description,this.price});
  factory Product.fromJson(Map<String,dynamic> json){
    return Product(
      id: json['id'] ,
      name: json['name'] ,
      description: json['description'],
      price: json['price'],

    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return 'Product{id: $id,name: $name,description: $description,price: $price}';
  }
}
