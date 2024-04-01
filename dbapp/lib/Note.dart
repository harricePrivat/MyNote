class Note {
  int? _id;
  String? _title;
  String? _content;
  Note({int? id, required String? title, required String? content}) {
    this._id = id;
    this._title = title;
    this._content = content;
  }
  int? getID() {
    return this._id;
  }

  String? getTitle() {
    return this._title;
  }

  String? getContent() {
    return this._content;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['title'] = _title;
    data['content'] = _content;
    return data;
  }
}
