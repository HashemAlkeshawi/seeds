class Category {
  int? id;
  String? title;
  String? imagePath;

  Category({required this.id, required this.title, required this.imagePath});

  Category.fromMap(Map<String, dynamic> map) {
    id = int.parse(map['id']);
    title = map['title'];
    imagePath = map['imageUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id!,
      'title': title!,
      'imageUrl': imagePath!,
    };
  }
}
