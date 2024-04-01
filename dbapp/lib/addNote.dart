import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:dbapp/database.dart';
import 'Note.dart';

class ContentApp extends StatefulWidget {
  const ContentApp({super.key});
  @override
  State<ContentApp> createState() => _ContentApp();
}

class _ContentApp extends State<ContentApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  String title = '';
  String content = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une note'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 70.00,
            width: 300.00,
            child: TextField(
              controller: titleController,
              maxLength: 20,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    //borderRadius: BorderRadius.horizontal(),
                    ),
                //filled: true,
                fillColor: Colors.blueAccent,
                prefixIcon: Icon(Icons.title_rounded),
                labelText: 'Titre',
              ),
              onChanged: (value) {
                title = value;
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50.00,
            width: 300.00,
            child: TextField(
              controller: contentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                prefixIcon: Icon(Icons.edit),
                labelText: 'Contenu',
              ),
              onChanged: (value) {
                content = value;
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 30,
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                if (title != '' && content != '') {
                  Note note = new Note(title: title, content: content);
                  insertData(note);
                  const snackBar = SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text('Note Ajoutée '),
                      ],
                    ),
                    duration: const Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  /* Fluttertoast.showToast(
                    msg: "Note Ajoutée",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey[700],
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );*/
                  title = '';
                  content = '';
                  titleController.clear();
                  contentController.clear();
                } else {
                  /*Fluttertoast.showToast(
                    msg: "Note Vide",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey[700],
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );*/

                  final snackBar = SnackBar(
                    content: Text('Note Vide'),
                    duration:
                        Duration(seconds: 2), // Durée d'affichage du message
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check),
                  SizedBox(
                    width: 20.00,
                  ),
                  Text("Valider"),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Future<void> insertData(Note note) async {
    int result = await DBHelper.insert(note);
    print("Voici le resultat $result");
  }
}
