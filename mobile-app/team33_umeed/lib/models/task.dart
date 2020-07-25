class Task {
  final String id;
  final String name;
  final String description;
  final DateTime start;
  final DateTime end;

  Task({this.id, this.name, this.description, this.start, this.end});

  Task.fromJSON(String id, Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        end = json['end'],
        start = json['start'];
}
