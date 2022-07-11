import 'package:flutter/cupertino.dart';

class TODO {
  late final listName;
  late final date;
  late final _list = <String>[];
  bool _isCompleted = false;

  TODO({@required this.listName, @required this.date});

  set addStep(String step) {
    _list.add(step);
  }

  bool removeStep(String step) => _list.remove(step);

  set setCompleted(bool val) {
    _isCompleted = val;
  }

  bool get getCompleted => _isCompleted;

  List<String> get getSteps => _list;
}
