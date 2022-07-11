import 'package:flutter/material.dart';
import '../Model/Todo.dart';

class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  late TODO _todo;
  final _stepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _todo = ModalRoute.of(context)?.settings.arguments as TODO;

    _addStep() {
      if (_stepController.text == '') {
        Navigator.of(context).pop();
      } else {
        setState(() {
          _todo.addStep = _stepController.text;
        });
        _stepController.text = '';
        Navigator.of(context).pop();
      }
    }

    _openModal() {
      showModalBottomSheet(
          context: context,
          builder: (_) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  const Text('Add Step'),
                  TextField(
                    autofocus: true,
                    controller: _stepController,
                    decoration: const InputDecoration(
                        label: Text('Step'),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0))),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: ElevatedButton(
                        onPressed: _addStep,
                        child: const Text(
                          'Add Step',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(
              '${_todo.listName[0].toUpperCase()}${_todo.listName.substring(1).toLowerCase()}')),
      // body: Text(_todo.getSteps[0]),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            decoration: BoxDecoration(
                color: const Color.fromARGB(130, 33, 149, 243),
                borderRadius: BorderRadius.circular(6)),
            child: ListTile(
              title: Text(_todo.getSteps[index]),
              trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _todo.removeStep(_todo.getSteps[index]);
                    });
                  }),
            ),
          );
        },
        itemCount: _todo.getSteps.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
