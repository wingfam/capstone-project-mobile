import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

import '../../models/models.dart';
import '../../utilities/util_functions.dart';
import '../auth/auth_service.dart';
import '../auth/auth_user.dart';

class BookingServices {
  final AuthUser _user = AuthService.firebase().currentUser!;
  final DatabaseReference _firebase = FirebaseDatabase.instance.ref();
  final DateFormat _formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss');
  BookingOrder _bookingOrder = BookingOrder();
  BookingCode _bookingCode = BookingCode();
  BookingHistory _history = BookingHistory();

  Future<void> createBooking(
    String validDate,
    String? lockerId,
    String currentTime,
  ) async {
    // Get a key for a new data.
    final newKey =
        FirebaseDatabase.instance.ref().child('booking_order').push().key;
    // Update BookingOrder model with new data
    _bookingOrder = BookingOrder(
      id: newKey,
      bookingDatetime: currentTime,
      bookingStatus: true,
      bookingValidDatetime: validDate,
      lockerId: lockerId,
      residentId: _user.id,
    );
    // Write the new data simultaneously in the newBooking list
    final Map<String, Map> create = {};
    create['/booking_order/$newKey'] = _bookingOrder.toJson();
    // Update to firebase
    await _firebase.update(create);
  }

  Future<String> createBookingCode(
    String currentTime,
  ) async {
    final bcodeName = get6DigitsCode().toString();
    final bcodeCreateDatetime = currentTime;
    final bcodeValidDatetime = _formattedDate.format(
      DateTime.now().add(
        const Duration(minutes: 10),
      ),
    );
    // Get a key for a new data.
    final newKey =
        FirebaseDatabase.instance.ref().child('booking_code').push().key;
    // Update BookingCode model with new data
    _bookingCode = BookingCode(
      bcodeCreateDatetime: bcodeCreateDatetime,
      bcodeName: bcodeName,
      bcodeValidDatetime: bcodeValidDatetime,
      bookingId: _bookingOrder.id,
    );
    // Write the new data simultaneously in the list
    final Map<String, Map> create = {};
    create['/booking_code/$newKey'] = _bookingCode.toJson();
    // Update to firebase
    await _firebase.update(create);
    // Return new booking code
    return _bookingCode.bcodeName!;
  }

  Future<void> createHistory(
    String? lockerName,
  ) async {
    final unlockCode = get6DigitsCode().toString();
    // Get a key for a new data.
    final newKey =
        FirebaseDatabase.instance.ref().child('booking_history').push().key;
    // Update BookingHistory model with new data
    _history = BookingHistory(
      bookingCode: _bookingCode.bcodeName,
      bookingId: _bookingOrder.id,
      lockerName: lockerName,
      residentId: _user.id,
      unlockCode: unlockCode,
    );
    // Write the new data simultaneously in the list
    final Map<String, Map> create = {};
    create['/booking_history/$newKey'] = _history.toJson();
    // Update to firebase
    await _firebase.update(create);
  }

  Future<Locker> getAvailableLockers() async {
    Locker locker = Locker();
    final snapshot = await _firebase.child("locker").get();
    final list = snapshot.value as Map;
    for (var item in list.entries) {
      if (item.value["locker_status"] == false) {
        locker = Locker(
          id: item.key,
          lockerName: item.value["locker_name"],
          lockerStatus: item.value["locker_status"],
        );
      }
    }
    return locker;
  }

  Future<void> updateLockerStatus(String? foundLockerId) async {
    final snapshot = _firebase.child("locker/$foundLockerId");
    final newStatus = {
      "locker_status": true,
    };
    snapshot.update(newStatus);
  }
}
