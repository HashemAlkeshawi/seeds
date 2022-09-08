import 'dart:developer';

class Reservation {
  String? id;
  late String customerId;
  late int guest;
  late String tableId;
  late DateTime reservedDate;
  int? reservationStatus;

  Reservation({
    this.id,
    required this.customerId,
    required this.tableId,
    required this.guest,
    required this.reservedDate,
    this.reservationStatus,
  });

  Reservation.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    customerId = map['customer_id'];
    tableId = map['table_id'];
    guest = int.parse(map['guest']);
    reservedDate = DateTime.parse(map['reservedDate']);
    reservationStatus = int.parse(map['reservationStatus'] ?? '0');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'tableId': tableId,
      "guest": guest,
      'reservedDate': reservedDate,
      'reservationStatus': reservationStatus ?? 0
    };
  }
}
