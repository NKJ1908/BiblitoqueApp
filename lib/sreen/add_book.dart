import 'package:flutter/material.dart';

class AddUpdatePage extends StatefulWidget {
  const AddUpdatePage({super.key});

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: Text("Bibliotèque"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("Bienvenue sur la page d'ajout"),
      )
      ),
    );
  }
}