import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../constants/routes.dart';
import '../../services/auth/auth_service.dart';
import '../../utilities/color_constant.dart';
import '../../utilities/image_constant.dart';
import '../../utilities/dialogs/logout_dialog.dart';
import '../login_screen/login.dart';
import 'change_password.dart';
import 'edit_info.dart';

enum MenuAction { logout }

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String get icProfile => ImageConstant.icProfile;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông tin cá nhân",
          style: TextStyle(
            color: Colors.white,
            fontSize: size.height * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(image: AssetImage(icProfile)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorConstant.primaryColor),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Tuấn Châu",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "tuanchau1008@gmail.com",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: const EditInfo(),
                    settings: const RouteSettings(name: editInfoRoute),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor,
                  side: BorderSide.none,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "Chỉnh sửa thông tin",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            //MENU
            ProfileMenuWidget(
              title: "Thông tin cá nhân",
              icon: Icons.account_circle,
              textColor: Colors.black,
              enIcon: true,
              onPress: () {},
            ),
            ProfileMenuWidget(
              title: "Đổi mật khẩu",
              icon: Icons.password,
              textColor: Colors.black,
              enIcon: true,
              onPress: () {
                pushNewScreenWithRouteSettings(
                  context,
                  screen: const ChangePassword(),
                  settings: const RouteSettings(name: changePasswordRoute),
                );
              },
            ),
            const Divider(),
            ProfileMenuWidget(
              title: "Điều khoản",
              icon: Icons.policy,
              textColor: Colors.black,
              enIcon: true,
              onPress: () {},
            ),
            ProfileMenuWidget(
              title: "Đăng xuất",
              icon: Icons.logout,
              textColor: Colors.red,
              enIcon: false,
              onPress: () async {
                final shouldLogout = await showLogoutDialog(context);
                if (shouldLogout) {
                  await AuthService.firebase().logOut();
                  if (context.mounted) {
                    pushNewScreenWithRouteSettings(
                      context,
                      screen: const LoginScreen(),
                      settings: const RouteSettings(name: loginRoute),
                      withNavBar: false,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    required this.enIcon,
    required this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool enIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey,
          ),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor),
        ),
        trailing: enIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.3),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18.0,
                  color: Colors.white,
                ),
              )
            : null);
  }
}
