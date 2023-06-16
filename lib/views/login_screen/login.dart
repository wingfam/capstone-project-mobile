import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants/routes.dart';
import '../../services/auth/auth_exceptions.dart';
import '../../services/auth/auth_service.dart';
import '../../utilities/color_constant.dart';
import '../../utilities/dialogs/error_dialog.dart';
import '../../utilities/image_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPass = false;
  late final ThemeData _theme;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _theme = ThemeData();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void closeAppUsingExit() {
    exit(0);
  }

  Future<void> verifyUserEmail() async {
    final email = _email.text;
    final password = _password.text;
    try {
      await AuthService.firebase().logIn(
        email: email,
        password: password,
      );
      final user = AuthService.firebase().currentUser;
      if (user?.email != null) {
        // user's email is verify
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            mainViewRoute,
            (route) => false,
          );
        }
      } else {
        // User's email is not verify
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            loginRoute,
            (route) => false,
          );
        }
      }
    } on UserNotFoundAuthException {
      await showErrorDialog(
        context,
        "Tài khoản không tồn tại.",
      );
    } on WrongPasswordAuthException {
      await showErrorDialog(
        context,
        "Password không đúng.",
      );
    } on GenericAuthException {
      await showErrorDialog(
        context,
        "Lỗi đăng nhập.",
      );
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Thoát ra ngoài'),
            content: const Text('Bạn có muốn thoát ra khỏi app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => closeAppUsingExit(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgLoginBg),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Image.asset(ImageConstant.appIcon,
                  height: size.height * 0.15, width: size.width * 0.3),
              Text(
                'Smart Locker',
                style: TextStyle(
                  fontSize: size.height * 0.042,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                  bottom: size.height * 0.03,
                  left: size.width * 0.07,
                  right: size.width * 0.07,
                ),
                child: Theme(
                  data: _theme.copyWith(
                    colorScheme: _theme.colorScheme
                        .copyWith(primary: ColorConstant.primaryColor),
                  ),
                  child: TextField(
                    style: TextStyle(
                        fontSize: size.width * 0.04, color: Colors.black),
                    cursorColor: ColorConstant.primaryColor,
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      errorText: null,
                      prefixIcon: SizedBox(
                        width: size.width * 0.05,
                        child: Icon(
                          Icons.phone,
                          size: size.width * 0.05,
                        ),
                      ),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: ColorConstant.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(size.width * 0.07, 0,
                    size.width * 0.07, size.height * 0.03),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Theme(
                      data: _theme.copyWith(
                        colorScheme: _theme.colorScheme
                            .copyWith(primary: ColorConstant.primaryColor),
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: Colors.black,
                        ),
                        obscureText: !_showPass,
                        onChanged: (value) {},
                        cursorColor: ColorConstant.primaryColor,
                        controller: _password,
                        decoration: InputDecoration(
                          errorText: null,
                          hintText: "Mật Khẩu",
                          prefixIcon: SizedBox(
                            width: size.width * 0.05,
                            child: Icon(
                              Icons.lock,
                              size: size.width * 0.05,
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.height * 0.02),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            onToggleShowPass();
                          });
                        },
                        child: Icon(
                          _showPass
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye_outlined,
                          color: _showPass
                              ? ColorConstant.primaryColor
                              : Colors.grey,
                          size: size.height * 0.028,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: size.width * 0.07,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Quên mật khẩu? ',
                        style: TextStyle(
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.07,
                  top: size.height * 0.03,
                  right: size.width * 0.07,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.055,
                  child: ElevatedButton(
                    onPressed: () async {
                      verifyUserEmail();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      textStyle: TextStyle(
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    child: const Text("Đăng nhập"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.03,
                  left: size.width * 0.07,
                  right: size.width * 0.07,
                ),
                child: Container(
                  width: size.width,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      textStyle: TextStyle(
                        fontSize: size.width * 0.045,
                      ),
                      elevation: 5,
                      shadowColor: Colors.grey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageConstant.imgGoogle,
                            width: size.height * 0.04),
                        Text(
                          '    Đăng nhập với Google',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                ),
                child: SizedBox(
                  width: size.width,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Chưa có tài khoản? ',
                          style: TextStyle(
                            fontSize: size.height * 0.017,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              registerRoute,
                            );
                          },
                          child: Text(
                            'Đăng ký',
                            style: TextStyle(
                              fontSize: size.height * 0.018,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Ứng dụng cho Khách hàng',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: size.height * 0.017,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
