import 'package:dbapp/database.dart';
import 'package:flutter/material.dart';
import 'Note.dart';

class ListNote extends StatefulWidget {
  const ListNote({super.key});
  @override
  State<ListNote> createState() => _ListNote();
}

class _ListNote extends State<ListNote> {
  bool cdtn = true;
  List<Note> note = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      note = await DBHelper.getAllData();
      setState(() {});
    } catch (error) {
      // Gérer les erreurs ici
      print('Erreur lors de la récupération des données : $error');
    }
  }

  Future<void> deleteAllData() async {
    try {
      for (int i = 0; i < note.length; i++) {
        DBHelper.delete(note[i]);
      }
      note.clear();
      setState(() {});
    } catch (error) {
      // Gérer les erreurs ici
      print('Erreur lors de la récupération des données : $error');
    }
  }

  // Future<List<Note>> getDatabase() async {
  //   List<Note> note = await DBHelper.getAllData();
  //   note;
  // }
  @override
  Widget build(BuildContext context) {
    if (note.isNotEmpty) {
      cdtn = false;
    }
    int nbData = note.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Notes: $nbData'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Effacer les notes"),
                    content: const Text("Tu veux effacer toutes les notes ?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Non"),
                      ),
                      TextButton(
                        onPressed: () {
                          deleteAllData();
                          Navigator.pop(context);
                        },
                        child: const Text("Oui"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: Container(
        child: cdtn
            ? const Center(
                child: Text(
                  'Il n\'ya pas de note',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: note.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      leading: IconButton(
                          onPressed: () {
                            String titleModif = "";
                            String contentModif = "";
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text('Modifier le texte'),
                                      content: Center(
                                        child: Column(children: [
                                          TextField(
                                            controller: TextEditingController(
                                                text: note[index]
                                                    .getTitle()
                                                    .toString()),
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Titre'),
                                            onChanged: (value) {
                                              titleModif = value;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 20.00,
                                          ),
                                          TextField(
                                            controller: TextEditingController(
                                                text: note[index]
                                                    .getContent()
                                                    .toString()),
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Contenu'),
                                            onChanged: (value) {
                                              contentModif = value;
                                            },
                                          ),
                                        ]),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              if (titleModif == "") {
                                                titleModif = note[index]
                                                    .getTitle()
                                                    .toString();
                                              }
                                              if (contentModif == "") {
                                                contentModif = note[index]
                                                    .getContent()
                                                    .toString();
                                              }
                                              Note n = Note(
                                                  id: note[index].getID(),
                                                  title: titleModif,
                                                  content: contentModif);
                                              note[index] = n;
                                              updateData(note[index]);
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Oui')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Non')),
                                      ],
                                    ));
                          },
                          icon: const Icon(Icons.edit)),
                      title: Text(note[index].getTitle().toString()),
                      subtitle: Text(note[index].getContent().toString()),
                      trailing: IconButton(
                          onPressed: () {
                            /*deleteData(note[index]);
                            note.remove(note[index]);
                            setState(() {});*/
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Supprimmer ce note"),
                                content: const Text(
                                    "Voulez vous supprimer ce note?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        deleteData(note[index]);
                                        note.remove(note[index]);
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      child: const Text("OUI")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Non")),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete)),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: ((context) => AlertDialog(
                                  title:
                                      Text(note[index].getTitle().toString()),
                                  content:
                                      Text(note[index].getContent().toString()),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("OK"))
                                  ],
                                )));
                      });
                }),
      ),
    );
  }

  Future<void> deleteData(Note note) async {
    DBHelper.delete(note);
  }

  Future<void> updateData(Note note) async {
    DBHelper.updateNote(note);
  }
}
