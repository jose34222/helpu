import 'package:flutter/material.dart';
import 'package:helpu/src/constants/sizes.dart';
import 'package:helpu/src/constants/text_strings.dart';
import 'package:helpu/src/features/core/screens/dashboard/widgets/add_practice_screen.dart';
import 'package:helpu/src/features/core/screens/dashboard/widgets/appbard.dart';
import 'package:helpu/src/features/core/screens/dashboard/widgets/banner.dart';
import 'package:helpu/src/features/core/screens/dashboard/widgets/category.dart';
import 'package:helpu/src/features/core/screens/dashboard/widgets/latest_addition.dart';
import 'package:helpu/src/features/core/screens/dashboard/widgets/search.dart';
import '../../models/dashboard/latest_model.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedCategory = 'IT'; // Categoría por defecto
  String searchQuery = ''; // Query de búsqueda
  List<DashboardLatestModel> filteredList = [];

  @override
  void initState() {
    super.initState();
    _filterList();
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      _filterList();
    });
  }

  void _onSearch(String query) {
    setState(() {
      searchQuery = query;
      _filterList();
    });
  }

  void _filterList() {
    setState(() {
      filteredList = DashboardLatestModel.list
          .where((item) =>
      (item.category == selectedCategory || selectedCategory == '') &&
          (item.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              item.heading.toLowerCase().contains(searchQuery.toLowerCase()) ||
              item.subHeading.toLowerCase().contains(searchQuery.toLowerCase())))
          .toList();
    });
  }

  void _addPractice(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPracticeScreen()),
    );
    if (result != null && result is DashboardLatestModel) {
      setState(() {
        DashboardLatestModel.addPractice(result);
        _filterList(); // Actualiza la lista filtrada
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const DashBoardAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDashboardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* -- Dashboard Header -- */
              Text(tDashboardTitle, style: textTheme.bodyMedium),
              Text(tDashboardHeading, style: textTheme.headlineMedium),

              /* -- Dashboard Search -- */
              const SizedBox(height: tDashboardPadding),
              DashboardSearchBar(
                textTheme: textTheme,
                onSearch: _onSearch,
              ),

              /* -- Dashboard Categories -- */
              const SizedBox(height: tDashboardPadding),
              DashboardCategory(
                textTheme: textTheme,
                onCategorySelected: _onCategorySelected,
              ),

              /* -- Dashboard Banner -- */
              const SizedBox(height: tDashboardPadding),
              DashboardBanner(textTheme: textTheme),

              /* -- Add Practice Button -- */
              const SizedBox(height: tDashboardPadding),
              ElevatedButton(
                onPressed: () => _addPractice(context),
                child: const Text('Añadir Práctica'),
              ),

              /* -- Dashboard Latest Addition -- */
              const SizedBox(height: tDashboardPadding),
              Text(
                'Prácticas añadidas',
                style: textTheme.headlineSmall,
              ),
              DashboardLatest(
                textTheme: textTheme,
                searchQuery: searchQuery, // Añadido para pasar la búsqueda
              ),
            ],
          ),
        ),
      ),
    );
  }
}