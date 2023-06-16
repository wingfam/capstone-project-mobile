import 'package:firebase_database/firebase_database.dart';

class NotificationDAO {
  DatabaseReference notificationScreen =
      FirebaseDatabase.instance.ref().child('/Notification');

  void saveInfo(String message) {
    final Map<dynamic, dynamic> body = <dynamic, dynamic>{};
    body.clear();
    body['message'] = message;

    //TaskHistory history = TaskHistory(dateTime: datetime, task: task, productLocation: location);
    notificationScreen.push().set(body);
  }

  Query getInfoQuery() {
    return notificationScreen;
  }
}
