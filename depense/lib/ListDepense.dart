import 'package:depense/MyDrawer.dart';
import 'package:depense/database.dart';
import 'package:flutter/material.dart';
import 'Depense.dart';

class ListeDepense extends StatefulWidget {
  const ListeDepense({super.key});
  @override
  State<ListeDepense> createState() => _ListeDepense();
}

class _ListeDepense extends State<ListeDepense> {
  List<Depense> listDepense = [];
  List<int> totalDepense = [];
  @override
  void initState() {
    super.initState();
    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste Depense "),
        backgroundColor: const Color.fromRGBO(176, 224, 230, 8),
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
        child: ListView.builder(
            itemCount: listDepense.length,
            itemBuilder: (context, index) {
              String desc = listDepense[index].getDescription().toString();
              String montant =
                  listDepense[index].getMontant().toString() + " Ar";
              String date = listDepense[index].getDate().toString();

              return ListTile(
                title: Text(
                  desc,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text("Effacer une depense"),
                                content: const Text(
                                    "Voulez-vous effacer ce depense?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        deleteData(listDepense[index]);
                                        listDepense.remove(listDepense[index]);
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      child: const Text("OUI")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("NON"))
                                ],
                              ));
                    },
                    icon: const Icon(Icons.delete)),
                subtitle: Row(
                  children: [
                    SizedBox(
                      width: 90,
                      child: Text(montant),
                    ),
                    const SizedBox(
                      width: 7.0,
                    ),
                    SizedBox(
                      width: 75,
                      child: Text(date),
                    ),
                  ],
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              "Depense",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: Center(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Description:  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(listDepense[index]
                                          .getDescription()
                                          .toString()),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.00,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Montant:  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(listDepense[index]
                                              .getMontant()
                                              .toString() +
                                          " Ar"),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.00,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Categorie:  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(listDepense[index]
                                          .getCategorie()
                                          .toString()),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.00,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Date:  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(listDepense[index]
                                          .getDate()
                                          .toString()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"))
                            ],
                          ));
                },
              );
            }),
      ),
    );
  }

  Future<void> getAllData() async {
    listDepense = await DBManager.getAllData();
    setState(() {});
  }

  Future<void> deleteData(Depense depense) async {
    DBManager.delete(depense);
    setState(() {});
  }
}
