class ModelKeepNotes {
  String? uId;
  String? title;
  String? description;

  ModelKeepNotes({this.title, this.description, required this.uId});

  ModelKeepNotes.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    description = json["description"];
    uId = json["uId"];
  }
  Map<String, dynamic> toJson() {
    return {"title": title, "description": description, "uId": uId};
  }
}
