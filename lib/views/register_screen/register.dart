import 'package:flutter/material.dart';

import '../../constants/routes.dart';
import '../../services/auth/auth_exceptions.dart';
import '../../services/auth/auth_service.dart';
import '../../utilities/color_constant.dart';
import '../../utilities/dialogs/error_dialog.dart';
import '../../utilities/dialogs/generic_dialog.dart';
import '../../utilities/image_constant.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late bool _showPass;
  late bool _isCommit;
  late final ThemeData _theme;
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password1;
  late final TextEditingController _password2;

  @override
  void initState() {
    _showPass = false;
    _isCommit = false;
    _theme = ThemeData();
    _name = TextEditingController();
    _email = TextEditingController();
    _password1 = TextEditingController();
    _password2 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password1.dispose();
    _password2.dispose();
    super.dispose();
  }

  void createUserCredential() async {
    final name = _name.text;
    final email = _email.text;
    final password1 = _password1.text;
    final password2 = _password2.text;

    try {
      if (password1 != password2) {
        showErrorDialog(context, "Two password must match");
      } else {
        await AuthService.firebase()
            .createUser(name: name, email: email, password: password1);
        // ignore: use_build_context_synchronously
        showGenericDialog(
          context: context,
          title: "Register Successful",
          content: "Press OK to continue to Login Screen",
          optionBuilder: () => {
            "OK": loginRoute,
          },
        );
      }
    } on WeakPasswordAuthException {
      showErrorDialog(
        context,
        "Weak password",
      );
    } on EmailAlreadyInUseAuthException {
      showErrorDialog(
        context,
        "Email is already used",
      );
    } on InvalidEmailAuthException {
      showErrorDialog(
        context,
        "This is an invalid email",
      );
    } on GenericAuthException {
      showErrorDialog(
        context,
        "Failed to register",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
          left: size.width * 0.07,
          right: size.width * 0.07,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.imgLoginBg),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                'Đăng ký',
                style: TextStyle(
                  fontSize: size.height * 0.042,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.06,
                ),
                child: Theme(
                  data: _theme.copyWith(
                    colorScheme: _theme.colorScheme
                        .copyWith(primary: ColorConstant.primaryColor),
                  ),
                  child: TextField(
                    onChanged: (value) {},
                    style: TextStyle(
                        fontSize: size.width * 0.04, color: Colors.black),
                    cursorColor: ColorConstant.primaryColor,
                    controller: _name,
                    decoration: InputDecoration(
                      hintText: "Họ và tên",
                      prefixIcon: SizedBox(
                        width: size.width * 0.05,
                        child: Icon(
                          Icons.account_circle_sharp,
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
                padding: EdgeInsets.only(
                  top: size.height * 0.02,
                ),
                child: Theme(
                  data: _theme.copyWith(
                    colorScheme: _theme.colorScheme
                        .copyWith(primary: ColorConstant.primaryColor),
                  ),
                  child: TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        fontSize: size.width * 0.04, color: Colors.black),
                    cursorColor: ColorConstant.primaryColor,
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: SizedBox(
                        width: size.width * 0.05,
                        child: Icon(
                          Icons.email,
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
                padding: EdgeInsets.only(
                  top: size.height * 0.02,
                ),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Theme(
                      data: _theme.copyWith(
                        colorScheme: _theme.colorScheme
                            .copyWith(primary: ColorConstant.primaryColor),
                      ),
                      child: TextField(
                        onChanged: (value) {},
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: Colors.black,
                        ),
                        obscureText: !_showPass,
                        cursorColor: ColorConstant.primaryColor,
                        controller: _password1,
                        decoration: InputDecoration(
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
                  top: size.height * 0.02,
                ),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Theme(
                      data: _theme.copyWith(
                        colorScheme: _theme.colorScheme
                            .copyWith(primary: ColorConstant.primaryColor),
                      ),
                      child: TextField(
                        onChanged: (value) {},
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: Colors.black,
                        ),
                        obscureText: !_showPass,
                        cursorColor: ColorConstant.primaryColor,
                        controller: _password2,
                        decoration: InputDecoration(
                          hintText: "Nhập lại mật khẩu",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(
                            (states) => ColorConstant.primaryColor),
                        focusColor: ColorConstant.primaryColor,
                        value: _isCommit,
                        onChanged: (bool? value) {
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Điều khoản & Cam kết",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.055,
                  child: ElevatedButton(
                    onPressed: () {
                      createUserCredential();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      textStyle: TextStyle(
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    child: const Text("Đăng ký"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: size.width * 0.3,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.05, right: size.width * 0.05),
                      child: Text(
                        "Hoặc ",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: size.height * 0.018,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: size.width * 0.3,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                  ],
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
                          'Đã có tài khoản? ',
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              loginRoute,
                            );
                          },
                          child: Text(
                            'Đăng nhập',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
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
