class HistoryDTO {
  HistoryDTO({
    required this.date,
    required this.booking_code,
    required this.locker_name,
    required this.unlock_code,});

  HistoryDTO.fromJson(dynamic json) {
    date = json['date'];
    booking_code = json['booking_code'];
    locker_name = json['locker_name'];
    unlock_code = json['unlock_code'];
  }
  // late String date;
  late String booking_code;
  late String locker_name;
  late String unlock_code;
  late String date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['booking_code'] = booking_code;
    map['locker_name'] = locker_name;
    map['unlock_code'] = unlock_code;
    return map;
  }

}