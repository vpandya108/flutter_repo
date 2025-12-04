import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController titleController = TextEditingController();

  List<Todo> todos = [];
  int selInd = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // add section
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Enter title",
                      labelText: "Title",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      // to add new todo
                      if (selInd == -1) {
                        todos.add(Todo(titleController.text, false));
                      } else {
                        todos[selInd].title = titleController.text;
                        selInd = -1;
                      }
                      titleController.clear();
                      setState(() {});
                    }
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            // display
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder:
                    (context, index) => CheckboxListTile(
                      onChanged: (v) {
                        todos[index].isCompleted = v!;
                        setState(() {});
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('${todos[index].title}'),
                      secondary: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            // edit the item from the list
                            IconButton(
                              onPressed: () {
                                titleController.text = todos[index].title;
                                selInd = index;
                              },
                              icon: Icon(Icons.edit),
                            ),
                            // delete the items from the list
                            IconButton(
                              onPressed: () {
                                todos.removeAt(index);
                                setState(() {});
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                      value: todos[index].isCompleted,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
