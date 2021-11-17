class Product {
  String? name;
  String? description;
  int? value;
  String? image;

  Product({this.name, this.description, this.value, this.image});

  Product.fromMap({required Map product}) {
    this.name = product['name'];
    this.description = product['description'];
    this.value = product['value'];
    this.image = product['image'];
  }
}
