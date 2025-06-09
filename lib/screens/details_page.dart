import 'package:biblioteque/db/book_database.dart';
import 'package:biblioteque/models/book.dart';
import 'package:biblioteque/screens/add_book.dart';
import 'package:flutter/material.dart';
class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key,required this.book});
  final Book book;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future <void>_deleteBook(BuildContext context) async{
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
          await BookDatabase.instance.delete(widget.book.id!);
        }
          }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.book.titre.toUpperCase()),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: ()async{
              await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUpdatePage(book: widget.book,)));
            }, 
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: ()=>_deleteBook(context))
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid)),
            child: Text("Titre: ${widget.book.titre}", style: const TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid)),
            child: Text("Auteur: ${widget.book.auteur}"),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid)),
            child: Text("Genre: ${widget.book.genre}"),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid)),
            child: Text("Année de publiation: ${widget.book.publicationYear}"),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid)),
            child: Text("Résumé: ${widget.book.resume}"),
          ),
        ],
      ),
      ),
      
    );
  }
}