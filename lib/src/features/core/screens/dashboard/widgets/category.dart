
import 'package:flutter/material.dart';
import 'package:helpu/src/constants/colors.dart';
import 'package:helpu/src/features/core/models/dashboard/categories_model.dart';
class DashboardCategory extends StatelessWidget {
  const DashboardCategory({
    Key? key,
    required this.textTheme,
    required this.onCategorySelected,
  }) : super(key: key);

  final TextTheme textTheme;
  final Function(String) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final list = DashboardCategoriesModel.list;

    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              onCategorySelected(list[index].title);
            },
            child: SizedBox(
              height: 50,
              width: 170,
              child: Row(
                children: [
                  Container(
                    width: 45,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: tDarkColor,
                    ),
                    child: Center(
                      child: Text(
                        list[index].title,
                        style: textTheme.headlineSmall?.apply(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          list[index].heading,
                          style: textTheme.headlineSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          list[index].subHeading,
                          style: textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
