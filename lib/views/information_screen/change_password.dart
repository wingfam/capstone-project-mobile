import 'package:flutter/material.dart';

import '../../utilities/color_constant.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa thông tin'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/homeScreen');
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(height: 30),
              buildTextField("Mật khẩu cũ", "**********", true),
              buildTextField("Mật khẩu mới", "*************", true),
              buildTextField("Xác nhận lại mật khẩu", "***************", true),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // OutlinedButton(
                  //   onPressed: () {},
                  //   child: Text("THOÁT",
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         letterSpacing: 2,
                  //         color: Colors.black
                  //     ),
                  //   ),
                  //   style: OutlinedButton.styleFrom(
                  //       padding: EdgeInsets.symmetric(horizontal: 50),
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(20))
                  //   ),
                  // ),
                  ElevatedButton(onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 170),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      child: const Text("LƯU",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 3,
                          color: Colors.white,
                        ),
                      )
                  )],
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? true : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )),
      ),
    );
  }
}
