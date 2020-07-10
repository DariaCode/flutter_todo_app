import 'package:flutter/material.dart';
import './add_todos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.green[600],
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.green[800], 
          ),
          headline2: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
         ),
      ),
      home: MyTodos("Todo list"),
    );
  }
}

class MyTodos extends StatefulWidget {
  MyTodos(this.title);

  final String title;

  @override
  _MyTodosState createState() => _MyTodosState();
}

class _MyTodosState extends State<MyTodos> {
  List<String> _todos = [
    "Do the dishes",
    "Walk the dog",
    "Water the plans",
    "Buy Groceries"
  ];

  List<String> _completeTodos = [
    "Take out the trash",
  ];

  List<Widget> _todoList() {
    List<Widget> children = [];
    for (int i=0; i < _todos.length; i++) {
      String item = _todos[i];
      children.add(TodoTile(
        title: item, 
        index: i,
        toggle: toggleDone,
        isDone: false,
        ));
    }
    return children;
  }

  List<Widget> _completeList() {
    List<Widget> children = [];
    for (int i=0; i < _completeTodos.length; i++) {
      String item = _completeTodos[i];
      children.add(TodoTile(
        title: item,
        index: i,
        toggle: toggleDone,
        isDone: true,
        ));
    }
    return children;
  }

  void _addTodo(BuildContext context) async {
    String newTodo = await showDialog(
      context: context,
      builder: (context) => AddTodoDialog()
      ); 

    if(newTodo != null) setState(() => _todos.add(newTodo)); 
  }

  void toggleDone(bool newValue, int index){
    if(newValue){
      String item = _todos[index];
      setState(() {
        _todos.removeAt(index);
        _completeTodos.add(item);
      });
    } else {
      String item = _completeTodos[index];
      setState(() {
      _completeTodos.removeAt(index);
      _todos.add(item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addTodo(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text("Todos", style: Theme.of(context).textTheme.headline1),
            SizedBox(height: 10),
            Column(
              children: _todoList(),
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            SizedBox(height: 16),
            Text("Completed", style: Theme.of(context).textTheme.headline1),
            SizedBox(height: 10),
            Column(
              children: _completeList(),
              crossAxisAlignment: CrossAxisAlignment.start,
            ),   
          ],
        ),
      ),
    );
  }
}


class TodoTile extends StatelessWidget {
  final String title;
  final bool isDone;
  final int index;
  final Function toggle;

  TodoTile({
    @required this.title,
    @required this.isDone,
    @required this.index,
    @required this.toggle,
    });

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]),
        borderRadius: BorderRadius.all(Radius.circular(12))
        ), // Birder.all // BoxDecoration
      child: Row(
        children: [
          Checkbox(
            value: this.isDone,
            onChanged: (bool newVal) => toggle(newVal, index),
            activeColor: Colors.green,
            ), // Checkbox
          Text(title),
        ],
      )
    );// Row // Container
  }

}