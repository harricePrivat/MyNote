import 'package:depense/ListDepense.dart';
import 'package:depense/Statistiques.dart';
import 'package:depense/searchDepense.dart';
import 'package:flutter/material.dart';
import 'database.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  State<MyDrawer> createState() => _MyDrawer();
}

class _MyDrawer extends State<MyDrawer> {
  List<String> fonctionnalite = [
    "- Statistiques des depenses",
    "- Listes des depenses",
    "- Rechercher une depense"
  ];
  List<int> totalDepense = [];
  @override
  void initState() {
    super.initState();
    getAllDepense();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(176, 224, 230, 8)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Calc Depense",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 20.00,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  const SizedBox(height: 10.00),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/logo.jpg"),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(fonctionnalite[0]),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Statistiques()));
            },
          ),
          ListTile(
              title: Text(fonctionnalite[1]),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListeDepense()));
              }),
          ListTile(
              title: Text(fonctionnalite[2]),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchDepense()));
              }),
          const SizedBox(
            height: 20.00,
          ),
          SizedBox(
              width: 200,
              height: 100,
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Total Depense: ',
                      //  selectionColor: Colors.redAccent,
                      style: TextStyle(
                        fontSize: 15.00,
                        fontStyle: FontStyle.italic,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      totalMonnaie().toString() + ' Ar',
                      //  selectionColor: Colors.redAccent,
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 25.00,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Future<void> getAllDepense() async {
    totalDepense = await DBManager.getAllDepense();
    setState(() {});
  }

  int totalMonnaie() {
    int total = 0;
    for (int i = 0; i < totalDepense.length; i++) {
      total += totalDepense[i];
    }
    return total;
  }
}
