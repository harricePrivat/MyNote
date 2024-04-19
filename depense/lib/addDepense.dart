import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'database.dart';
import 'Depense.dart';
import 'package:intl/intl.dart';

class AddDepense extends StatefulWidget {
  const AddDepense({super.key});
  @override
  State<AddDepense> createState() => _AddDepense();
}

class _AddDepense extends State<AddDepense> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? selectedDate = DateTime.now();
  TextEditingController descController = TextEditingController();
  TextEditingController montantController = TextEditingController();
  final List<String> options = ['Loisir', 'Alimentation', 'Loyer', 'Autre'];
  String dropdownValue = 'Loisir';
  bool switchValue = false;
  String description = "";
  int montant = 0;
  String categorie = "";
  String date = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(176, 224, 230, 8),
        title: const Text(
          "Ajouter une dépense",
          style: TextStyle(
            //  color: Colors.blueAccent,
            fontStyle: FontStyle.italic,
            fontSize: 15.00,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: const Color.fromRGBO(176, 224, 230, 2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 250.00,
              height: 35.00,
              child: TextField(
                controller: descController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description du dépense"),
                onChanged: (value) {
                  description = value;
                },
              ),
            ),
            const SizedBox(
              height: 25.00,
            ),
            SizedBox(
              width: 250.00,
              height: 35.00,
              child: TextField(
                controller: montantController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Montant en Ariary"),
                onChanged: (value) {
                  montant = int.parse(value);
                },
              ),
            ),
            const SizedBox(
              height: 25.00,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Catégorie:",
                    style: TextStyle(
                      // color: Colors.blueAccent,
                      //fontStyle: FontStyle.italic,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5.00),
                  DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      // Met à jour la valeur sélectionnée lorsque l'utilisateur change l'option
                      setState(() {
                        dropdownValue = newValue.toString();
                      });
                    },
                    style: const TextStyle(
                      color: Colors.blueGrey, // Couleur du texte
                      fontSize: 12, // Taille du texte
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic, // Poids de la police
                    ),
                    // Taille de l'icône déroulante
                    iconSize: 20,
                    // Elevation de l'ombre
                    elevation: 15,
                    // Personnalisation de l'élément sous la liste déroulante
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                    // Personnalisation de l'icône déroulante
                    icon: const Icon(Icons.arrow_downward),
                    items:
                        options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Une date:",
                    style: TextStyle(
                      // color: Colors.blueAccent,
                      //fontStyle: FontStyle.italic,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5.00),
                  Switch(
                    value: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        _showDocumentation(context);
                      },
                      icon: const Icon(Icons.info)),
                ],
              ),
            ),
            if (switchValue)
              SizedBox(
                width: 250.00,
                height: 35.00,
                child: TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: const InputDecoration(
                    //labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            const SizedBox(
              height: 25.00,
            ),
            ElevatedButton(
                onPressed: () {
                  if (montant != 0 || description != "") {
                    descController.clear();
                    montantController.clear();
                    if (date == "") {
                      date = selectedDate.toString();
                      date =
                          "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}";
                    }
                    Depense depense = Depense(
                        description: description,
                        montant: montant,
                        categorie: dropdownValue,
                        date: date);
                    insertDepense(depense);
                    final snackBar = SnackBar(
                      content: Text("Depense ajoute"),
                      duration: const Duration(
                          seconds: 2), // Durée d'affichage du message
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    dropdownValue = 'Autre';
                    description = "";
                    date = "";
                    montant = 0;
                    if (switchValue) {
                      switchValue = false;
                    }
                  } else {
                    final snackBar = SnackBar(
                      content: Text("Inserer toutes les donnees"),
                      duration: const Duration(
                          seconds: 2), // Durée d'affichage du message
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    dropdownValue = 'Autre';
                    description = "";
                    date = "";
                    montant = 0;
                    if (switchValue) {
                      switchValue = false;
                    }
                  }

                  setState(() {});
                },
                child: const Text("Ajouter ce dépense")),
          ],
        ),
      ),
    );
  }

  void _showDocumentation(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Date'),
            content: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vous pouvez utiliser la date présent,',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Ou ajoutez une date spécifique de votre dépense.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fermer'),
              ),
            ],
          );
        });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
        date = _dateController.text;
      });
    } else {
      date = selectedDate.toString();
    }
  }

  Future<void> insertDepense(Depense depense) async {
    int id = await DBManager.insert(depense);
    print("Donne inserer avec id $id");
  }
}
