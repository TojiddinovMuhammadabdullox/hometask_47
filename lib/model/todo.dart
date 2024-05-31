class Todo {
  String id;
  String title;
  String description;
  String time;

  Todo({
    this.id = '',
    this.title = '',
    this.description = '',
    this.time = '',
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'time': time,
    };
  }
}
