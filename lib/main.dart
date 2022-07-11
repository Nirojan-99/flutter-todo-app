import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'Screen/Steps.dart';
import 'Model/Todo.dart';
import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO App',
      debugShowCheckedModeBanner: false,
      routes: {'/list': (ctx) => const Steps()},
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? _date;
  late TODO newTodo;
  bool _tasksArrowrrowDown = true;
  bool _completedArrowrrowDown = true;
  late var _isVisible;
  late var _hideButtonController;

  var _todoList = <TODO>[];
  final _completedTodoList = <TODO>[];

  final _todoController = TextEditingController();

  _openModel() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            child: Column(children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Add Todo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                autofocus: true,
                controller: _todoController,
                decoration: const InputDecoration(
                    label: Text('Todo Name'),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton(
                      onPressed: _openDatePicker,
                      child: const Text(
                        'Select Date',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ))),
              Container(
                  padding: const EdgeInsets.only(top: 15),
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                      onPressed: _addTodo,
                      child: const Text(
                        'ADD',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))),
            ]),
          );
        });
  }

  _closeDialogBox() {
    Navigator.of(context).pop();
  }

  _deleteTODO(TODO todo, list) {
    setState(() {
      list.remove(todo);
    });
    Navigator.of(context).pop();
  }

  _deleteDialog(int index, var list) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            elevation: 16,
            // ignore: avoid_unnecessary_containers
            child: Container(
              decoration: const BoxDecoration(color: Colors.white54),
              padding: const EdgeInsets.all(4),
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height * .15,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Remove ?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      TextButton(
                          onPressed: _closeDialogBox,
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red, elevation: 0),
                          onPressed: () {
                            _deleteTODO(list[index], list);
                          },
                          child: const Text(
                            'Remove',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  _openDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        _date = value!;
      });
    });
  }

  _addTodo() {
    if (_todoController.text == '' || _date == null) {
      Navigator.of(context).pop();
    } else {
      newTodo = TODO(listName: _todoController.text, date: _date);
      setState(() {
        _todoList.add(newTodo);
      });
      _todoController.text = '';
      _date = null;
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _todoList = todoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('TODO'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, right: 5, left: 5),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            // _completedArrowrrowDown = !_completedArrowrrowDown;
                            _tasksArrowrrowDown = !_tasksArrowrrowDown;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Tasks (${_todoList.length})',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              _tasksArrowrrowDown
                                  ? const Icon(
                                      Icons.arrow_drop_up_rounded,
                                      size: 40,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.arrow_drop_down_rounded,
                                      size: 40,
                                      color: Colors.black,
                                    )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              Container(
                  child: _tasksArrowrrowDown
                      ? SizedBox(
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: InkWell(
                                  onLongPress: () {
                                    _deleteDialog(index, _todoList);
                                  },
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/list',
                                        arguments: _todoList[index]);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black12,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 0),
                                    child: ListTile(
                                        trailing: Checkbox(
                                          activeColor: Colors.blue,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7.0))),
                                          onChanged: (val) {
                                            setState(() {
                                              _todoList[index].setCompleted =
                                                  val!;
                                              TODO temp = _todoList[index];
                                              _todoList.remove(temp);
                                              _completedTodoList.add(temp);
                                            });
                                          },
                                          value: _todoList[index].getCompleted,
                                        ),
                                        subtitle: Text(
                                            '${_todoList[index].date.day.toString()}-${_todoList[index].date.month.toString()}-${_todoList[index].date.year.toString()}'),
                                        title: Text(
                                          '${_todoList[index].listName[0].toUpperCase()}${_todoList[index].listName.substring(1).toLowerCase()}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 2, 90, 162)),
                                        )),
                                  ),
                                ),
                              );
                            },
                            itemCount: _todoList.length,
                          ),
                        )
                      : Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, right: 5, left: 5),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            _completedArrowrrowDown = !_completedArrowrrowDown;
                            // _tasksArrowrrowDown = !_tasksArrowrrowDown;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Completed (${_completedTodoList.length})',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              _completedArrowrrowDown
                                  ? const Icon(
                                      Icons.arrow_drop_up_rounded,
                                      size: 40,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.arrow_drop_down_rounded,
                                      size: 40,
                                      color: Colors.black,
                                    )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                  child: !_completedArrowrrowDown
                      ? ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: InkWell(
                                onLongPress: () {
                                  _deleteDialog(index, _completedTodoList);
                                },
                                onTap: () {
                                  Navigator.of(context).pushNamed('/list',
                                      arguments: _completedTodoList[index]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black12,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 0),
                                  child: ListTile(
                                      trailing: Checkbox(
                                        activeColor: Colors.blue,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7.0))),
                                        onChanged: (val) {
                                          setState(() {
                                            _completedTodoList[index]
                                                .setCompleted = val!;
                                            TODO temp =
                                                _completedTodoList[index];
                                            _completedTodoList.remove(temp);
                                            _todoList.add(temp);
                                          });
                                        },
                                        value: _completedTodoList[index]
                                            .getCompleted,
                                      ),
                                      subtitle: Text(
                                          '${_completedTodoList[index].date.day.toString()}-${_completedTodoList[index].date.month.toString()}-${_completedTodoList[index].date.year.toString()}'),
                                      title: Text(
                                        '${_completedTodoList[index].listName[0].toUpperCase()}${_completedTodoList[index].listName.substring(1).toLowerCase()}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 2, 90, 162)),
                                      )),
                                ),
                              ),
                            );
                          },
                          itemCount: _completedTodoList.length,
                        )
                      : Container()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openModel,
        tooltip: "Add New Todo",
        child: const Icon(Icons.add),
      ),
    );
  }
}
