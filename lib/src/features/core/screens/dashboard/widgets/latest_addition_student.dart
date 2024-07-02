import 'package:flutter/material.dart';
import 'package:helpu/src/constants/colors.dart';
import 'package:helpu/src/constants/image_strings.dart';
import 'package:helpu/src/constants/sizes.dart';
import 'package:helpu/src/features/core/screens/dashboard/widgets/detalle_postulacion.dart';
import 'package:helpu/src/features/practica/controller/practica_controller.dart';
import 'package:get/get.dart';

class DashboardLatestStudent extends StatelessWidget {
  const DashboardLatestStudent({
    Key? key,
    required this.textTheme,
    required this.searchQuery,
  }) : super(key: key);

  final TextTheme textTheme;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PracticaController());

    return Obx(() {
      controller.getPracticas();
      if (controller.practicasList.isEmpty) {
        return Center(
          child: Text(
            'No hay prácticas disponibles',
          ),
        );
      }

      return SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: controller.practicasList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostulacionDetailScreen(practice: controller.practicasList[index]),
                ),
              );
            },
            child: SizedBox(
              width: 320,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, top: 5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tCardBgColor,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              controller.practicasList[index].titulo,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.black)
                            ),
                          ),
                          const Flexible(
                            child: Image(
                              image: AssetImage(tDashboardLatestImage),
                              height: 110,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            onPressed: () {},
                            child: const Icon(Icons.play_arrow),
                          ),
                          const SizedBox(width: tDashboardCardPadding),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.practicasList[index].encabezado,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  controller.practicasList[index].descripcion,
                                  style: TextStyle(color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
