
import 'package:flutter/material.dart';
import 'package:helpu/src/constants/colors.dart';
import 'package:helpu/src/constants/image_strings.dart';
import 'package:helpu/src/constants/sizes.dart';
import 'package:helpu/src/constants/text_strings.dart';
import 'package:helpu/src/features/core/screens/dashboard/widgets/practice_info_screen.dart'; // Asegúrate de que la ruta sea correcta

class DashboardBanner extends StatelessWidget {
  const DashboardBanner({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PracticeInfoScreen()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: tSecondaryColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Image(image: AssetImage(tBookMarkImage)),
                      ),
                      Flexible(
                        child: Image(image: AssetImage(tDashboardBannerImage)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Encuentra tus Prácticas",
                    style: textTheme.titleLarge?.apply(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Prácticas preprofesionales en Ecuador",
                    style: textTheme.bodyMedium?.apply(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: tDashboardCardPadding),
        Expanded(
          child: Column(
            children: [
              //Card
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PracticeInfoScreen()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tCardBgColor,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Image(image: AssetImage(tBookMarkImage))),
                          Flexible(
                              child: Image(
                                  image: AssetImage(tDashboardBannerImage1))),
                        ],
                      ),
                      Text("Prácticas en POSGRADOS",
                          style: textTheme.headlineMedium,
                          overflow: TextOverflow.ellipsis),
                      Text("Explora oportunidades en diversas industrias",
                          style: textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PracticeInfoScreen()),
                        );
                      },
                      child: const Text("Ver Más")
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
