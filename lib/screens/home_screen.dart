import 'package:biblioteque/db/book_database.dart';
import 'package:biblioteque/models/book.dart';
import 'package:biblioteque/screens/add_book.dart';
import 'package:biblioteque/screens/details_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Book>> books;

@override
  void initState() {
    super.initState();
    books = BookDatabase.instance.readAllbooks();
  }

  void refreshbooks() {
    setState(() {
      books = BookDatabase.instance.readAllbooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Accueil"), backgroundColor: Colors.blue),
      body: FutureBuilder<List<Book>>(
        future: books,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Votre bibliotèque est vide."));
          }
          final list = snapshot.data!;

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final book = list[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Icon(Icons.book, color: Colors.blueGrey, weight: 20,),
                  title: Text(book.titre.toUpperCase(),style: TextStyle(fontSize: 20),),
                  subtitle: Text("${book.auteur.toUpperCase()} - ${book.publicationYear}",style: TextStyle(fontSize: 15),),
                  trailing: IconButton(icon: Icon(Icons.delete,color: Colors.red),onPressed: ()async{
                    final confirm = await showDialog<bool>(context: context, builder: (context) => AlertDialog(
                      title: Text("Confirmation"),
                      content: Text("Voulez-vous supprimer ce livre?"),
                      actions: [
                        TextButton(
                          onPressed: ()=>Navigator.pop(context, false), 
                          child: const Text("Annuler")),
                        ElevatedButton(onPressed: ()=>Navigator.pop(context, true), child: const Text("Supprimer"))
                      ],
                    ));

                    if (confirm == true){
                      await BookDatabase.instance.delete(book.id!);
                      refreshbooks();
                    }
                  },                                                                         
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailsPage(book:book)),
                    );
                    refreshbooks();
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddUpdatePage()));
        refreshbooks();
      },
      child: Icon(Icons.add),),
    );
  }
}
