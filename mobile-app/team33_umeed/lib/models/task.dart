class Task {
  final String id;
  final String name;
  final String description;
  final String start;
  final String end;
  final int quantity;

  Task(
      {this.id,
      this.name,
      this.description,
      this.start,
      this.end,
      this.quantity});

  Task.fromJSON(String id, Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        end = json['end'],
        start = json['start'],
        quantity = json['quantity'];
}
