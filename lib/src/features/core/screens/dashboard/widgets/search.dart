
import 'package:flutter/material.dart';
import 'package:helpu/src/constants/text_strings.dart';

import 'package:flutter/material.dart';

class DashboardSearchBar extends StatelessWidget {
  final TextTheme textTheme;
  final ValueChanged<String> onSearch;

  const DashboardSearchBar({
    Key? key,
    required this.textTheme,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Buscar',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: onSearch,
    );
  }
}
