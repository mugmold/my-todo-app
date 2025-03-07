// Model class Todo
class Todo {
  String name;
  bool isComplete;

  Todo({
    required this.name,
    this.isComplete = false,
  });

  // Convert Todo object ke Map ataupun sebaliknya (buat json)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isComplete': isComplete,
    };
  }

  static Todo fromMapToTodo(Map<String, dynamic> map) {
    return Todo(
      name: map['name'],
      isComplete: map['isComplete'],
    );
  }
}
