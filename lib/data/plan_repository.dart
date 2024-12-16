import 'package:flutter/foundation.dart';

// Model classes
class Todo {
  Todo({
    required this.title,
    this.isDone = false,
  });
  String title;
  bool isDone;
}

class TodoList {
  TodoList({
    required this.title,
    List<Todo>? items,
  }) : items = items ?? [];
  String title;
  List<Todo> items;
}

class PlanRepository extends ChangeNotifier {
  final List<TodoList> _lists = [];

  // Getters
  List<TodoList> get lists => List.unmodifiable(_lists);

  // Methods to manage TodoLists
  void addList(String title) {
    _lists.add(TodoList(title: title));
    notifyListeners();
  }

  void removeList(int listIndex) {
    if (listIndex >= 0 && listIndex < _lists.length) {
      _lists.removeAt(listIndex);
      notifyListeners();
    }
  }

  void updateListTitle(int listIndex, String newTitle) {
    if (listIndex >= 0 && listIndex < _lists.length) {
      _lists[listIndex].title = newTitle;
      notifyListeners();
    }
  }

  // Methods to manage Todo items within lists
  void addTodoItem(int listIndex, String title) {
    if (listIndex >= 0 && listIndex < _lists.length) {
      _lists[listIndex].items.add(Todo(title: title));
      notifyListeners();
    }
  }

  void removeTodoItem(int listIndex, int itemIndex) {
    if (listIndex >= 0 && listIndex < _lists.length) {
      if (itemIndex >= 0 && itemIndex < _lists[listIndex].items.length) {
        _lists[listIndex].items.removeAt(itemIndex);
        notifyListeners();
      }
    }
  }

  void toggleTodoStatus(int listIndex, int itemIndex) {
    if (listIndex >= 0 && listIndex < _lists.length) {
      if (itemIndex >= 0 && itemIndex < _lists[listIndex].items.length) {
        _lists[listIndex].items[itemIndex].isDone =
            !_lists[listIndex].items[itemIndex].isDone;
        notifyListeners();
      }
    }
  }

  void updateTodoTitle(int listIndex, int itemIndex, String newTitle) {
    if (listIndex >= 0 && listIndex < _lists.length) {
      if (itemIndex >= 0 && itemIndex < _lists[listIndex].items.length) {
        _lists[listIndex].items[itemIndex].title = newTitle;
        notifyListeners();
      }
    }
  }
}
