import 'package:firebase_database/firebase_database.dart';

class HistoryDAO {
  DatabaseReference taskHistory =
      FirebaseDatabase.instance.ref().child('/booking_history');

  void saveInfo(
      String bookingCode, String lockerName, String unlockCode, String date) {
    final Map<dynamic, dynamic> body = <dynamic, dynamic>{};
    body.clear();
    body['booking_code'] = bookingCode;
    body['locker_name'] = lockerName;
    body['unlockcode'] = unlockCode;
    body['date'] = date;

    //TaskHistory history = TaskHistory(dateTime: datetime, task: task, productLocation: location);
    taskHistory.push().set(body);
  }

  Query getInfoQuery() {
    return taskHistory;
  }
}
