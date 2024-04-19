import 'package:depense/MyDrawer.dart';
import 'package:flutter/material.dart';
import "Depense.dart";
import 'database.dart';

class SearchDepense extends StatefulWidget {
  const SearchDepense({super.key});
  @override
  State<SearchDepense> createState() => _SearchDepense();
}

class _SearchDepense extends State<SearchDepense> {
  List<Depense> listDepense = [];
  List<Depense> listResult = [];
  Future<void> getAllData() async {
    listDepense = await DBManager.getAllData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  Future<void> deleteData(Depense depense) async {
    await DBManager.delete(depense);
  }

  void rechercherElement(String recherche) {
    listResult.clear();
    if (recherche.isEmpty) {
      listResult.addAll(listDepense);
    } else {
      for (Depense element in listDepense) {
        if (element
            .getDescription()
            .toString()
            .toLowerCase()
            .contains(recherche.toLowerCase())) {
          listResult.add(element);
        }
      }
    }
    setState(() {});
  }

  String recherche = "";
  TextEditingController rechercheController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(176, 224, 230, 2),
        title: const Text("Chercher une depense"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      drawer: const MyDrawer(),
      backgroundColor: const Color.fromRGBO(176, 224, 230, 2),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20.00,
            ),
            SizedBox(
              width: 250.00,
              height: 35.00,
              child: TextFormField(
                controller: rechercheController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Rechercher depense",
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  //String recherche = '';
                  if (value == '') listResult.clear();
                  rechercherElement(value);
                },
              ),
            ),
            const SizedBox(
              height: 20.00,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listResult.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      listResult[index].getDescription() ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        SizedBox(
                          width: 90,
                          child: Text(
                              listResult[index].getMontant().toString() + 'Ar'),
                        ),
                      ],
                    ),
                    trailing: Text(listResult[index].getDate().toString()),
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
