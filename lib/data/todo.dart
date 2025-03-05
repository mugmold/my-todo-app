class Todo {
  String name;
  bool isComplete;

  Todo({
    required this.name,
    this.isComplete = false,
  });

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
