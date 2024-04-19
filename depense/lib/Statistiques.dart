import 'package:depense/MyDrawer.dart';
import 'package:depense/database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Statistiques extends StatefulWidget {
  const Statistiques({super.key});
  @override
  State<Statistiques> createState() => _Statistiques();
}

class _Statistiques extends State<Statistiques> {
  List<int> allLoyer = [];
  List<int> allLoisir = [];
  List<int> allAutre = [];
  List<int> allAlimentation = [];
  List<int> totalDepense = [];
  @override
  void initState() {
    super.initState();
    getAllDepense();
    getAllAutre();
    getAllLoyer();
    getAllLoisir();
    getAllAlimentation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(176, 224, 230, 8),
        title: const Text("Stats des depenses "),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      backgroundColor: const Color.fromRGBO(176, 224, 230, 8),
      drawer: const MyDrawer(),
      body: Center(
        child: SfCircularChart(
          legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.scroll,
              position: LegendPosition.bottom,
              orientation: LegendItemOrientation.vertical),
          series: <CircularSeries>[
            PieSeries<PieData, String>(
              dataSource: <PieData>[
                PieData(
                    'Alimentation', totalMonnaie(allAlimentation).toDouble()),
                PieData('Loyer', totalMonnaie(allLoyer).toDouble()),
                PieData('Loisir', totalMonnaie(allLoisir).toDouble()),
                PieData('Autre', totalMonnaie(allAutre).toDouble()),
              ],
              xValueMapper: (PieData data, _) => data.category,
              yValueMapper: (PieData data, _) => data.value,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getAllLoyer() async {
    allLoyer = await DBManager.getAllLoyer();
    setState(() {});
  }

  Future<void> getAllLoisir() async {
    allLoisir = await DBManager.getAllLoisir();
    setState(() {});
  }

  Future<void> getAllAutre() async {
    allAutre = await DBManager.getAllAutre();
    setState(() {});
  }

  Future<void> getAllAlimentation() async {
    allAlimentation = await DBManager.getAllAlimentation();
    setState(() {});
  }

  int totalMonnaie(List<int> totalDepense) {
    int total = 0;
    for (int i = 0; i < totalDepense.length; i++) {
      total += totalDepense[i];
    }
    return total;
  }

  Future<void> getAllDepense() async {
    totalDepense = await DBManager.getAllDepense();
    setState(() {});
  }
}

class PieData {
  final String category;
  final double value;

  PieData(this.category, this.value);
}
