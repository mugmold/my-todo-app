// Model class Todo
class Todo {
  String name;
  String description;
  bool isComplete;

  Todo({
    required this.name,
    this.description = '',
    this.isComplete = false,
  });

  // Convert Todo object ke Map ataupun sebaliknya (buat json)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'isComplete': isComplete,
    };
  }

  static Todo fromMapToTodo(Map<String, dynamic> map) {
    return Todo(
      name: map['name'],
      description: map['description'],
      isComplete: map['isComplete'],
    );
  }
}
