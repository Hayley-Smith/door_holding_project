import 'package:door_holding_project/about_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'observation_model.dart';
import 'observation_provider.dart';

// Define Enums
enum HoldingType { fullHold, partialHold, noHold, noneSelected }

enum Gender { male, female, other, noneSelected }

enum AgeGroup { teen, adult, senior, noneSelected }

enum Distance { within5ft, between5And10ft, moreThan10ft, noneSelected }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ObservationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Set up the animation to move from left to right
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _controller.forward();

    // Initialize the TabController
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Door Holding Behavior Analysis'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'About'),
              Tab(text: 'Holding Type'),
              Tab(text: 'Gender'),
              Tab(text: 'Age Group'),
              Tab(text: 'Distance'),
              Tab(text: 'Data Table'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            AboutPage(),
            ObservationChartPage(
              offsetAnimation: _offsetAnimation,
              chartType: 'holdingType',
            ),
            ObservationChartPage(
              offsetAnimation: _offsetAnimation,
              chartType: 'gender',
            ),
            ObservationChartPage(
              offsetAnimation: _offsetAnimation,
              chartType: 'ageGroup',
            ),
            ObservationChartPage(
              offsetAnimation: _offsetAnimation,
              chartType: 'distance',
            ),
            ObservationTablePage(),
          ],
        ),
      ),
    );
  }
}

// Page to show the chart
class ObservationChartPage extends StatelessWidget {
  final Animation<Offset> _offsetAnimation;
  final String chartType;

  const ObservationChartPage({
    super.key,
    required Animation<Offset> offsetAnimation,
    required this.chartType,
  }) : _offsetAnimation = offsetAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Consumer<ObservationProvider>(
        builder: (context, observationProvider, child) {
          List<Observation> observations = observationProvider.observations;

          return Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  '${chartType.capitalize()} Distribution',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Center(
                  child: buildPieChart(
                    observations,
                    chartType,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Page to show the table
class ObservationTablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ObservationProvider>(
      builder: (context, observationProvider, child) {
        List<Observation> observations = observationProvider.observations;

        return SingleChildScrollView(
          child: Center(
            child: buildObservationTable(observations),
          ),
        );
      },
    );
  }
}

// Build Pie Chart
Widget buildPieChart(List<Observation> observations, String fieldType) {
  int firstTypeCount = 0;
  int secondTypeCount = 0;
  int thirdTypeCount = 0;

  switch (fieldType) {
    case 'holdingType':
      firstTypeCount = observations
          .where((obs) => obs.holdingType == HoldingType.fullHold)
          .length;
      secondTypeCount = observations
          .where((obs) => obs.holdingType == HoldingType.partialHold)
          .length;
      thirdTypeCount = observations
          .where((obs) => obs.holdingType == HoldingType.noHold)
          .length;
      break;
    case 'gender':
      firstTypeCount =
          observations.where((obs) => obs.gender == Gender.male).length;
      secondTypeCount =
          observations.where((obs) => obs.gender == Gender.female).length;
      thirdTypeCount =
          observations.where((obs) => obs.gender == Gender.other).length;
      break;
    case 'ageGroup':
      firstTypeCount =
          observations.where((obs) => obs.ageGroup == AgeGroup.teen).length;
      secondTypeCount =
          observations.where((obs) => obs.ageGroup == AgeGroup.adult).length;
      thirdTypeCount =
          observations.where((obs) => obs.ageGroup == AgeGroup.senior).length;
      break;
    case 'distance':
      firstTypeCount = observations
          .where((obs) => obs.distance == Distance.within5ft)
          .length;
      secondTypeCount = observations
          .where((obs) => obs.distance == Distance.between5And10ft)
          .length;
      thirdTypeCount = observations
          .where((obs) => obs.distance == Distance.moreThan10ft)
          .length;
      break;
  }

  return SizedBox(
    height: 400,
    child: PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: firstTypeCount.toDouble(),
            title: formatEnumText(fieldType, 1),
            color: Colors.deepPurple[300],
          ),
          PieChartSectionData(
            value: secondTypeCount.toDouble(),
            title: formatEnumText(fieldType, 2),
            color: Colors.deepPurple[200],
          ),
          PieChartSectionData(
            value: thirdTypeCount.toDouble(),
            title: formatEnumText(fieldType, 3),
            color: Colors.deepPurple[100],
          ),
        ],
      ),
    ),
  );
}

// Helper Method to Format Enum Text using 'toString()' and trimming the enum name
String formatEnumText(String fieldType, int typeNumber) {
  switch (fieldType) {
    case 'holdingType':
      return typeNumber == 1
          ? 'Full Hold'
          : typeNumber == 2
              ? 'Partial Hold'
              : 'No Hold';
    case 'gender':
      return typeNumber == 1
          ? 'Male'
          : typeNumber == 2
              ? 'Female'
              : 'Other';
    case 'ageGroup':
      return typeNumber == 1
          ? 'Teen'
          : typeNumber == 2
              ? 'Adult'
              : 'Senior';
    case 'distance':
      return typeNumber == 1
          ? 'Within 5ft'
          : typeNumber == 2
              ? '5-10ft'
              : 'More than 10ft';
    default:
      return 'Unknown';
  }
}

// Extension to Capitalize String
extension StringCasingExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

// Build Bar Chart for Holding Type Distribution
Widget buildBarChart(List<Observation> observations) {
  int fullHoldCount = observations
      .where((obs) => obs.holdingType == HoldingType.fullHold)
      .length;
  int partialHoldCount = observations
      .where((obs) => obs.holdingType == HoldingType.partialHold)
      .length;
  int noHoldCount =
      observations.where((obs) => obs.holdingType == HoldingType.noHold).length;

  return SizedBox(
    height: 400,
    width: 400,
    child: BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(toY: fullHoldCount.toDouble(), color: Colors.blue),
          ], showingTooltipIndicators: [
            0
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
                toY: partialHoldCount.toDouble(), color: Colors.green),
          ], showingTooltipIndicators: [
            0
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(toY: noHoldCount.toDouble(), color: Colors.red),
          ], showingTooltipIndicators: [
            0
          ]),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Text('Full Hold');
                  case 1:
                    return const Text('Partial Hold');
                  case 2:
                    return const Text('No Hold');
                  default:
                    return const Text('');
                }
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
        ),
      ),
    ),
  );
}

// Build Observation Data Table
Widget buildObservationTable(List<Observation> observations) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      columns: const [
        DataColumn(label: Text('Holding Type')),
        DataColumn(label: Text('Gender')),
        DataColumn(label: Text('Age Group')),
        DataColumn(label: Text('Distance')),
      ],
      rows: observations.map((obs) {
        return DataRow(cells: [
          DataCell(
              Text(formatEnumText('holdingType', obs.holdingType.index + 1))),
          DataCell(Text(formatEnumText('gender', obs.gender.index + 1))),
          DataCell(Text(formatEnumText('ageGroup', obs.ageGroup.index + 1))),
          DataCell(Text(formatEnumText('distance', obs.distance.index + 1))),
        ]);
      }).toList(),
    ),
  );
}
