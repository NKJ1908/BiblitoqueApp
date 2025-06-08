import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bbliotèque"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("Bienvenue sur la page des détails"),
      ),
    );
  }
}