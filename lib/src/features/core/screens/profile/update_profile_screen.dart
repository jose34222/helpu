import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/constants/colors.dart';
import 'package:helpu/src/constants/sizes.dart';
import 'package:helpu/src/constants/text_strings.dart';
import 'package:helpu/src/features/authetication/model/user_model.dart';
import 'package:helpu/src/features/core/controllers/profile_controller.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              LineAwesomeIcons.angle_left,
            )),
        title: Text(tEditProfile, style: Theme.of(context).textTheme.headlineMedium),
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
            future: controller.getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;

                  final email = TextEditingController(text: user.email);
                  final password = TextEditingController(text: user.password);
                  final name = TextEditingController(text: user.fullName);
                  final phone = TextEditingController(text: user.phoneNo);

                  return Column(
                    children: [
                      // -- IMAGE with ICON
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
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
                                  borderRadius: BorderRadius.circular(100), color: tPrimaryColor),
                              child: const Icon(LineAwesomeIcons.camera,
                                  color: Colors.black, size: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),

                      // -- Form Fields
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: name,
                              decoration: const InputDecoration(
                                  label: Text(tFullName), prefixIcon: Icon(LineAwesomeIcons.user)),
                            ),
                            const SizedBox(height: tDefaultSize - 20),
                            TextFormField(
                              controller: email,
                              decoration: const InputDecoration(
                                  label: Text(tEmail),
                                  prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
                            ),
                            const SizedBox(height: tDefaultSize - 20),
                            TextFormField(
                              controller: phone,
                              decoration: const InputDecoration(
                                  label: Text(tPhoneNo), prefixIcon: Icon(LineAwesomeIcons.phone)),
                            ),
                            const SizedBox(height: tDefaultSize - 20),
                            TextFormField(
                              controller: password,
                              obscureText: true,
                              decoration: InputDecoration(
                                label: const Text(tPassword),
                                prefixIcon: const Icon(Icons.fingerprint),
                                suffixIcon: IconButton(
                                    icon: const Icon(LineAwesomeIcons.eye_slash), onPressed: () {}),
                              ),
                            ),
                            const SizedBox(height: tDefaultSize),

                            // -- Form Submit Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final userData = UserModel(
                                      fullName: name.text,
                                      email: email.text,
                                      phoneNo: phone.text,
                                      password: password.text);
                                  await controller.updateUser(user);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: tPrimaryColor,
                                    side: BorderSide.none,
                                    shape: const StadiumBorder()),
                                child:
                                const Text(tEditProfile, style: TextStyle(color: tDarkColor)),
                              ),
                            ),
                            const SizedBox(height: tDefaultSize),

                            // -- Created Date and Delete Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text.rich(
                                  TextSpan(
                                    text: tJoined,
                                    style: TextStyle(fontSize: 12),
                                    children: [
                                      TextSpan(
                                          text: tJoinedAt,
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent.withOpacity(0.1),
                                      elevation: 0,
                                      foregroundColor: Colors.red,
                                      shape: const StadiumBorder(),
                                      side: BorderSide.none),
                                  child: const Text(tDelete),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text('Something went wrong!'));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
