import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart' show Notifications;
import '../../services/crud/notification_dao.dart';
import '../../utilities/color_constant.dart';

class Noti extends StatefulWidget {
  const Noti({Key? key}) : super(key: key);

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  final notification = NotificationDAO();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Thông báo",
          style: TextStyle(
            color: Colors.white,
            fontSize: size.height * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: size.height,
            child: FirebaseAnimatedList(
              query: notification.getInfoQuery(),
              itemBuilder: (context, snapshot, animation, index) {
                final json = snapshot.value;
                final data = Notifications.fromJson(json);
                return Card(
                  child: ListTile(
                    leading: Container(
                      width: 5,
                      height: 55,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                    ),
                    title: Text('Thông báo:${data.message.toString()}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
