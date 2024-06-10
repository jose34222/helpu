
import 'package:flutter/material.dart';
import 'package:helpu/src/constants/sizes.dart';

class FormFooter extends StatelessWidget {
  const FormFooter({
    super.key,
    required this.actionStudent,
    required this.onTapStudent,
    required this.actionCompany,
    required this.onTapCompany
  });

  final String  actionStudent, actionCompany;
  final VoidCallback onTapStudent, onTapCompany;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(height: tDefaultSize - 20),
      TextButton(
        onPressed: onTapStudent,
        child: Text.rich(
              TextSpan(
                  text: actionStudent, style: const TextStyle(color: Colors.blue)),
          ),
        ),
      const SizedBox(height: tDefaultSize - 20),
      TextButton(onPressed: onTapCompany,
          child: Text.rich(
              TextSpan(
                text: actionCompany, style: const TextStyle(color: Colors.blue),
              ),

          ),
      ),
    ])
    );
  }
}