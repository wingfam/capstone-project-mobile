import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/models.dart' show BookingHistory;
import '../../services/crud/history_dao.dart';
import '../../services/crud/booking_service.dart';
import '../../utilities/color_constant.dart';
import '../../utilities/dialogs/show_new_code_dialog.dart';
import '../../utilities/util_functions.dart';

enum MenuAction { newBookingCode, newUnlockCode }

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final HistoryDAO _history = HistoryDAO();
  final BookingServices _services = BookingServices();
  final DateFormat _formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss');
  String newBookingCode = "";
  String newUnlockCode = "";

  String getNewCode() {
    final newCode = get6DigitsCode().toString();
    return newCode.toString();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Lịch sử booking",
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
              query: _history.getInfoQuery(),
              itemBuilder: (context, snapshot, animation, index) {
                final json = snapshot.value;
                final key = snapshot.key;
                final data = BookingHistory.fromJson(json);
                return Card(
                  child: ListTile(
                    trailing: PopupMenuButton<MenuAction>(
                      onSelected: (value) async {
                        switch (value) {
                          case MenuAction.newBookingCode:
                            newBookingCode = getNewCode();
                            final currentTime = DateTime.now();
                            // TODO: làm delay 1 phút sau khi đã tạo mã
                            await _services.updateBCodeHistory(
                                newBookingCode, key!);
                            await _services.createBookingCode(
                              data.bookingId,
                              newBookingCode,
                              _formattedDate.format(currentTime),
                            );
                            if (context.mounted) {
                              return showNewCode(
                                context: context,
                                title: "Mã booking mới",
                                newCode: newBookingCode,
                                optionBuilder: () => {
                                  // TODO: làm copy mã vào clipboard
                                  "Copy": null,
                                  "OK": null,
                                },
                              );
                            }
                            break;
                          case MenuAction.newUnlockCode:
                            newUnlockCode = getNewCode();
                            await _services.updateUCodeHistory(
                              newUnlockCode,
                              key!,
                            );
                            await _services.updateUnlockCode(
                              newUnlockCode,
                              data.bookingId,
                            );
                            if (context.mounted) {
                              return showNewCode(
                                context: context,
                                title: "Mã unlock mới",
                                newCode: newUnlockCode,
                                optionBuilder: () => {
                                  "OK": null,
                                },
                              );
                            }
                        }
                      },
                      itemBuilder: (context) {
                        return const [
                          PopupMenuItem<MenuAction>(
                              value: MenuAction.newBookingCode,
                              child: Text("New booking code")),
                          PopupMenuItem<MenuAction>(
                              value: MenuAction.newUnlockCode,
                              child: Text("New unlock code")),
                        ];
                      },
                    ),
                    leading: Container(
                      width: 5,
                      height: 55,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                    ),
                    title: Text(
                      'Thời hạn: ${data.date}\n'
                      'Mã số tủ: ${data.lockerName}',
                    ),
                    subtitle: Text(
                      'Unlock Code: ${data.unlockCode}\n'
                      'Booking Code: ${data.bookingCode}\n',
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
