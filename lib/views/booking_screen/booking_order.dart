import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../services/crud/booking_service.dart';
import '../../utilities/dialogs/generic_dialog.dart';
import '../../utilities/image_constant.dart';
import '../../utilities/util_functions.dart';

const List<String> validDatetimeList = <String>[
  '1 tiếng',
  '3 tiếng',
  '6 tiếng',
  '1 ngày',
];

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late final BookingServices _bookingServices;
  late String _message;
  late DateFormat _formattedDate;
  late String _dropdownValue;
  late ValueNotifier<bool> _isLoading;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _bookingServices = BookingServices();
    _message =
        "Sau khi tạo booking, mã booking sẽ có hiệu lực trong 10 phút.Khi hết 10 phút, bạn sẽ phải tạo booking khác để sử dụng.;";
    _formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss');
    _dropdownValue = validDatetimeList.first;
    _isLoading = ValueNotifier(false);
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _isLoading.removeListener(() {
      showLoadingDialog();
    });
    EasyLoading.removeAllCallbacks();
    super.dispose();
  }

  void showLoadingDialog() async {
    await EasyLoading.show(
      status: "Đang tìm tủ trống ...",
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.black,
    );
  }

  String convertDropDownValue(String dropdownValue) {
    DateTime validDate = DateTime.now();
    int number = int.parse(dropdownValue.substring(0, 1));
    String time = dropdownValue.substring(2, dropdownValue.length);
    if (time == "tiếng") {
      validDate = validDate.add(Duration(hours: number));
    } else if (time == "ngày") {
      validDate = validDate.add(Duration(days: number));
    }
    String validDateString = _formattedDate.format(validDate);
    return validDateString;
  }

  Future<void> bookNewLocker(BuildContext context) async {
    final foundLocker = await _bookingServices.getAvailableLockers();
    await EasyLoading.dismiss();
    if (foundLocker.lockerName == null) {
      if (context.mounted) {
        showGenericDialog(
          context: context,
          title: "Không có tủ trống.",
          content: "Bạn vui lòng đặt lại vào lần sau.",
          optionBuilder: () => {
            "OK": null,
          },
        );
      }
    } else {
      final currentTime = _formattedDate.format(DateTime.now());
      final validate = convertDropDownValue(_dropdownValue);
      final bookingId = await _bookingServices.createBooking(
        validate,
        foundLocker.id,
        currentTime,
      );

      final bcodeName = get6DigitsCode().toString();
      final newCode = await _bookingServices.createBookingCode(
        bookingId,
        currentTime,
        bcodeName,
      );

      await _bookingServices.createHistory(
        foundLocker.lockerName,
      );

      await _bookingServices.updateLockerStatus(foundLocker.id);
      if (context.mounted) {
        showGenericDialog(
          context: context,
          title: "Tủ được book thành công",
          content:
              "Mã số tủ booking là: $newCode.\nHãy xem lịch sử booking để lấy mã unlock tủ.",
          optionBuilder: () => {
            "OK": null,
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tạo booking"),
      ),
      body: Center(
        child: Card(
          elevation: 10.0,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            heightFactor: 0.85,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                  child: Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Container(
                  width: size.width * 0.6,
                  height: size.width * 0.6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageConstant.imgCreateBooking),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Chọn thời hạn booking: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.blueAccent),
                        underline: Container(
                          height: 2,
                          color: Colors.blueAccent,
                        ),
                        onChanged: (String? value) => setState(() {
                          _dropdownValue = value ?? "";
                        }),
                        items: validDatetimeList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () async {
                          // TODO: Rã các function sang file crud cho dễ quản lí
                          showLoadingDialog();
                          await bookNewLocker(context);
                        },
                        child: const Text(
                          "Đặt tủ",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
