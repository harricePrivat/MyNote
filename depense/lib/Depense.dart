class Depense {
  int? _id;
  String? _description;
  int? _montant;
  String? _categorie;
  String? _date;
  Depense(
      {int? id,
      required String? description,
      required int? montant,
      required String? categorie,
      required String? date}) {
    _id = id;
    _description = description;
    _montant = montant;
    _categorie = categorie;
    _date = date;
  }

  String? getDescription() {
    return _description;
  }

  int? getMontant() {
    return _montant;
  }

  int? getId() {
    return _id;
  }

  String? getCategorie() {
    return _categorie;
  }

  String? getDate() {
    return _date;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['description'] = _description;
    data['montant'] = _montant;
    data['date'] = _date;
    data['categorie'] = _categorie;
    return data;
  }
}
