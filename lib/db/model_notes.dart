class Note {
  int? id;
  String? title;
  String? description;
  String? datetime;

  Note({required this.id, required this.title, required this.description, required this.datetime});


  //String-> Map
  factory Note.fromJson(Map<String, dynamic> Json) => Note(
        id: Json['id'],
        title: Json['title'],
        description: Json['description'],
    datetime: Json['datetime']
      );

  //Map-> to String
  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'description': description, 'datetime':datetime};
}
