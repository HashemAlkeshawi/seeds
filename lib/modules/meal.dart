class Meal {
  String? id;
  String? categoryId;
  String? title;
  int? price;
  String? imagePath;
  String? descreption;
  bool hasSale = false;
  int? salePrice;
  double? rating;
  String? saleDays;
  bool isPopular = false;

  Meal(
      {this.id,
      required this.categoryId,
      required this.title,
      required this.price,
      required this.imagePath,
      this.saleDays,
      this.descreption,
      this.hasSale = false,
      this.isPopular = false,
      this.salePrice,
      required this.rating});

  Meal.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    categoryId = map['category_id'];
    title = map['title'];
    price = int.parse(map['price'] ?? '0');
    imagePath = map['imageUrl'];
    descreption = map['description'];
    saleDays = map['saleDays'];
    hasSale = int.parse(map['hasSale'] ?? '0') == 1 ? true : false;
    isPopular = int.parse(map['isPopular'] ?? '0') == 1 ? true : false;
    salePrice = int.parse(map['salePrice'] ?? '0');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'title': title ?? 'title',
      'price': price,
      'imageUrl': imagePath ?? 'assets/icons/categories/feather.png',
      'description': descreption,
      'saleDays': saleDays,
      'hasSale': hasSale ? 1 : 0,
      'isPopular': isPopular ? 1 : 0,
      'salePrice': salePrice,
    };
  }
}
