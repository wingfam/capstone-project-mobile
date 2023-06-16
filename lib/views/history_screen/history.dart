import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../models/historyDTO.dart';
import '../../services/crud/history_dao.dart';
import '../../utilities/color_constant.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final HistoryDAO history = HistoryDAO();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Thông tin cá nhân",
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
              query: history.getInfoQuery(),
              itemBuilder: (context, snapshot, animation, index) {
                final json = snapshot.value;
                final data = HistoryDTO.fromJson(json);
                return Card(
                  child: ListTile(
                    leading: Container(
                      width: 5,
                      height: 55,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                    ),
                    title: Text(
                      'Mã số tủ:${data.locker_name.toString()}\n'
                      'Ngày:${data.date.toString()}',
                    ),
                    subtitle: Text(
                      'Unlock Code: ${data.unlock_code.toString()}\n'
                      'Booking Code: ${data.booking_code.toString()}',
                    ),
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
