import 'package:flutter/material.dart';
import 'package:helpu/src/constants/colors.dart';
import 'package:helpu/src/constants/image_strings.dart';
import 'package:helpu/src/constants/sizes.dart';
import 'package:helpu/src/features/core/screens/dashboard/widgets/detalle_postulacion.dart';
import 'package:helpu/src/features/practica/controller/practica_controller.dart';
import 'package:helpu/src/features/practica/model/practica_model.dart';
import 'package:get/get.dart';

class DashboardLatestStudent extends StatelessWidget {
  const DashboardLatestStudent({
    Key? key,
    required this.textTheme,
    required this.searchQuery, // Añadido el parámetro searchQuery
  }) : super(key: key);

  final TextTheme textTheme;
  final String searchQuery; // Añadida la declaración del parámetro

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PracticaController());

    return FutureBuilder<List<PracticaModel>>(
      future: controller.getPracticas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final listPracticas = controller.filterPracticas(snapshot.data ?? [], searchQuery);
          return SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: listPracticas.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostulacionDetailScreen(practice: listPracticas[index]),
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
                                  listPracticas[index].titulo,
                                  style: textTheme.headlineMedium?.copyWith(color: Colors.black),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                                      listPracticas[index].encabezado,
                                      style: textTheme.headlineMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      listPracticas[index].descripcion,
                                      style: textTheme.headlineMedium?.copyWith(color: Colors.black),
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
        }
      },
    );
  }
}
