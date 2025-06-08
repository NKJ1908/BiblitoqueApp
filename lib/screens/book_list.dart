import 'package:biblioteque/screens/add_book.dart';
import 'package:biblioteque/screens/details_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final books = [
    {
      "titre":"Bible",
      "auteur":"DIEU",
      "image":"assets/images/book.jpg",
    },
    {
      "titre":"Power",
      "auteur":"Peter GREEN",
      "image":"assets/images/book.jpg",
    },
    {
      "titre":"Demain dès l'aube",
      "auteur":"Victor HUGO",
      "image":"assets/images/book.jpg",
    },
    {
      "titre":"Misérables",
      "auteur":"Victor HUGO",
      "image":"assets/images/book.jpg",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Accueil"),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index){
              final book = books[index];
              final String? titre = book["titre"];
              final String? auteur = book["auteur"];
              final String? image = book["image"];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Image(image: AssetImage(image??"pas d'image")),
                  title: Text(titre?? "Pas de titre", style: TextStyle(fontSize: 20),),
                  subtitle: Text(auteur?? "pas d'auteur",style: TextStyle(fontSize: 15),),
                  trailing: Icon(Icons.more_vert),iconColor: Colors.red,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage()));
                  },
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUpdatePage()));
        },child: Icon(Icons.add),tooltip: "Ajouter un livre",),
    );
  }
}