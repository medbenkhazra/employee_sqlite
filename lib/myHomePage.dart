import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Column(
        children: [

        ]
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
              Navigator.pushNamed(context, '/add_employee');
          }
        , label: Text('Add Employee'),
        icon: Icon(Icons.add),
        ),
    );
  }
}