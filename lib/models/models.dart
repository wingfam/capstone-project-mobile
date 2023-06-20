class Resident {
  String? email;
  String? name;
  String? password;

  Resident({this.email, this.name, this.password});

  static Resident fromMap(Map value) {
    return Resident(
      email: value['email'],
      name: value['name'],
      password: value['password'],
    );
  }

  Resident.fromJson(dynamic json) {
    email = json['email'];
    name = json['name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    return data;
  }
}

class Locker {
  String? id;
  String? lockerName;
  bool? lockerStatus;

  Locker({this.id, this.lockerName, this.lockerStatus});

  static Locker fromMap(Map value) {
    return Locker(
      lockerName: value['locker_name'],
      lockerStatus: value['locker_status'],
    );
  }

  Locker.fromJson(dynamic json) {
    lockerName = json['locker_name'];
    lockerStatus = json['locker_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locker_name'] = lockerName;
    data['locker_status'] = lockerStatus;
    return data;
  }
}

class BookingOrder {
  String? id;
  String? bookingDatetime;
  bool? bookingStatus;
  String? bookingValidDatetime;
  String? lockerId;
  String? residentId;

  BookingOrder(
      {this.id,
      this.bookingDatetime,
      this.bookingStatus,
      this.bookingValidDatetime,
      this.lockerId,
      this.residentId});

  static BookingOrder fromMap(Map value) {
    return BookingOrder(
      bookingDatetime: value['booking_datetime'],
      bookingStatus: value['booking_status'],
      bookingValidDatetime: value['booking_valid_datetime'],
      lockerId: value['locker_id'],
      residentId: value['resident_id'],
    );
  }

  BookingOrder.fromJson(dynamic json) {
    bookingDatetime = json['booking_datetime'];
    bookingStatus = json['booking_status'];
    bookingValidDatetime = json['booking_valid_datetime'];
    lockerId = json['locker_id'];
    residentId = json['resident_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_datetime'] = bookingDatetime;
    data['booking_status'] = bookingStatus;
    data['booking_valid_datetime'] = bookingValidDatetime;
    data['locker_id'] = lockerId;
    data['resident_id'] = residentId;
    return data;
  }
}

class UnlockCode {
  String? bookingId;
  String? ucodeCreateDatetime;
  String? ucodeName;

  UnlockCode({this.bookingId, this.ucodeCreateDatetime, this.ucodeName});

  static UnlockCode fromMap(Map value) {
    return UnlockCode(
      bookingId: value['booking_id'],
      ucodeCreateDatetime: value['ucode_create_datetime'],
      ucodeName: value['ucode_name'],
    );
  }

  UnlockCode.fromJson(dynamic json) {
    bookingId = json['booking_id'];
    ucodeCreateDatetime = json['ucode_create_datetime'];
    ucodeName = json['ucode_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_id'] = bookingId;
    data['ucode_create_datetime'] = ucodeCreateDatetime;
    data['ucode_name'] = ucodeName;
    return data;
  }
}

class BookingHistory {
  String? residentId;
  String? bookingCode;
  String? bookingId;
  String? lockerName;
  String? unlockCode;
  String? date;

  BookingHistory({
    this.residentId,
    this.bookingCode,
    this.bookingId,
    this.lockerName,
    this.unlockCode,
    this.date,
  });

  static BookingHistory fromMap(Map value) {
    return BookingHistory(
      residentId: value['resident_id'],
      bookingCode: value['booking_code'],
      bookingId: value['booking_id'],
      lockerName: value['locker_name'],
      unlockCode: value['unlock_code'],
      date: value['date'],
    );
  }

  BookingHistory.fromJson(dynamic json) {
    residentId = json['resident_id'];
    bookingCode = json['booking_code'];
    bookingId = json['booking_id'];
    lockerName = json['locker_name'];
    unlockCode = json['unlock_code'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resident_id'] = residentId;
    data['booking_code'] = bookingCode;
    data['booking_id'] = bookingId;
    data['locker_name'] = lockerName;
    data['unlock_code'] = unlockCode;
    data['date'] = date;
    return data;
  }
}

class BookingCode {
  String? bcodeCreateDatetime;
  String? bcodeName;
  String? bcodeValidDatetime;
  String? bookingId;

  BookingCode(
      {this.bcodeCreateDatetime,
      this.bcodeName,
      this.bcodeValidDatetime,
      this.bookingId});

  static BookingCode fromMap(Map value) {
    return BookingCode(
      bcodeCreateDatetime: value['bcode_create_datetime'],
      bcodeName: value['bcode_name'],
      bcodeValidDatetime: value['bcode_valid_datetime'],
      bookingId: value['booking_id'],
    );
  }

  BookingCode.fromJson(dynamic json) {
    bcodeCreateDatetime = json['bcode_create_datetime'];
    bcodeName = json['bcode_name'];
    bcodeValidDatetime = json['bcode_valid_datetime'];
    bookingId = json['booking_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bcode_create_datetime'] = bcodeCreateDatetime;
    data['bcode_name'] = bcodeName;
    data['bcode_valid_datetime'] = bcodeValidDatetime;
    data['booking_id'] = bookingId;
    return data;
  }
}

class Notifications {
  String? residentId;
  String? message;
  String? createDate;

  Notifications({this.residentId, this.message, this.createDate});

  static Notifications fromMap(Map value) {
    return Notifications(
      residentId: value['resident_id'],
      message: value['message'],
      createDate: value['create_date'],
    );
  }

  Notifications.fromJson(dynamic json) {
    residentId = json['resident_id'];
    message = json['message'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resident_id'] = residentId;
    data['message'] = message;
    data['create_date'] = createDate;
    return data;
  }
}
