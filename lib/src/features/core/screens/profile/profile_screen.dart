import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/constants/colors.dart';
import 'package:helpu/src/constants/sizes.dart';
import 'package:helpu/src/constants/text_strings.dart';
import 'package:helpu/src/features/core/controllers/profile_controller.dart';
import 'package:helpu/src/features/core/screens/profile/widgets/menu.dart';
import 'package:helpu/src/repository/authentication_repository/authentication_repository.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(tProfile, style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      clipBehavior: Clip.antiAlias,
                      child: const Icon(
                        LineAwesomeIcons.user,
                        size: 120,
                        color: tPrimaryColor,
                      ),
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
                        color: tPrimaryColor,
                      ),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              ProfileMenuWidget(
                title: 'Cerrar Sesión',
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  Get.defaultDialog(
                    title: 'CERRAR SESIÓN',
                    titleStyle: const TextStyle(fontSize: 20),
                    content: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('¿Estás seguro que quieres cerrar sesión?'),
                    ),
                    confirm: ElevatedButton(
                      onPressed: () => AuthenticationRepository.instance.logOut(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        side: BorderSide.none,
                      ),
                      child: const Text('Sí'),
                    ),
                    cancel: OutlinedButton(
                      onPressed: () => Get.back(),
                      child: const Text('No'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
