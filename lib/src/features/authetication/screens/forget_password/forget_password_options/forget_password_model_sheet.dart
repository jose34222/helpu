
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/constants/sizes.dart';
import 'package:helpu/src/constants/text_strings.dart';
import 'package:helpu/src/features/authetication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:helpu/src/features/authetication/screens/forget_password/forget_password_options/forget_password_btn_widget.dart';

class ForgetPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      builder: (context) => Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tForgotPasswordTitle,
                style: Theme.of(context).textTheme.displayMedium),
            Text(tForgotPasswordSubTitle,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: tDefaultSize),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.mail_outline_rounded,
              title: 'E-Mail',
              subTitle: tForgotPasswordEmail,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const ForgetPasswordMailScreen());
              },
            ),
            const SizedBox(height: tDefaultSize),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.phone,
              title: 'Phone',
              subTitle: tForgotPasswordPhone,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}