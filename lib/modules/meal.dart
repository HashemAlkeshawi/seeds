class Meal {
  String? id;
  String? title;
  int? price;
  String? imagePath;
  String? descreption;
  bool hasSale = false;
  int? salePrice;
  double? rating;

  Meal(
      {required this.id,
      required this.title,
      required this.price,
      required this.imagePath,
      this.descreption,
      this.hasSale = false,
      this.salePrice,
      required this.rating});

  Meal.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    price = int.parse(map['price']);
    imagePath = map['imageUrl'];
    descreption = map['descreption'];
    hasSale = int.parse(map['hasSale']) == 1 ? true : false;
    salePrice = int.parse(map['salePrice']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id!,
      'title': title!,
      'price': price,
      'imageUrl': imagePath!,
      'descreption': descreption,
      'hasSale': hasSale,
      'salePrice': salePrice,
    };
  }
}
