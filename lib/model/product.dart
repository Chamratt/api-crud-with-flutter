class Product{
 final int? id;
 final String? name;
 final String? description;
 final dynamic price;
 final dynamic qty;

  Product({ this.id,this.name,this.description,this.price,this.qty});
  factory Product.fromJson(Map<String,dynamic> json){
    return Product(
      id: json['id'] ,
      name: json['name'] ,
      description: json['description'],
      price: json['price'],
      qty: json['qty']

    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return 'Product{id: $id,name: $name,description: $description,price: $price}';
  }

}
