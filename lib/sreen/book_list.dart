import 'package:biblioteque/sreen/add_book.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Accueil"),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView(
            children: [
              Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Image(image: AssetImage("assets/images/book.jpg")),
                  title: Text("Titre du livre", style: TextStyle(fontSize: 20),),
                  subtitle: Text("Nom de l'auteur",style: TextStyle(fontSize: 15),),
                  trailing: Icon(Icons.more_vert),iconColor: Colors.red,
                  onTap: () {
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUpdatePage()));
        },child: Icon(Icons.add),tooltip: "Ajouter un livre",),
      ),
    );
  }
}