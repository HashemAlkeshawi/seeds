class Customer {
  late String id;
  late String fullName;
  late String phone;
  String? imageUrl;
  int? status;
  int? isReserved;
  Customer({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.imageUrl,
    this.status,
    this.isReserved,
  });

  Customer.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    fullName = map['fullName'];
    phone = map['phone'];
    imageUrl = map['imageUrl'];
    status = int.parse(map['status'] ?? '0');
    isReserved = int.parse(map['isReserved'] ?? '0');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'imageUrl': imageUrl,
      'status': status ?? 0,
      'isReserved': isReserved ?? 0
    };
  }
}
