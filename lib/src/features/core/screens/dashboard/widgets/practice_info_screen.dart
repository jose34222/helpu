import 'package:flutter/material.dart';

class PracticeInfoScreen extends StatelessWidget {
  const PracticeInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de las Prácticas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalles de las Prácticas',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Aquí encontrarás toda la información sobre las prácticas preprofesionales disponibles en Ecuador.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            // Agrega más contenido aquí según sea necesario
          ],
        ),
      ),
    );
  }
}
