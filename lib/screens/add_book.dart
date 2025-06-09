import 'package:biblioteque/db/book_database.dart';
import 'package:biblioteque/models/book.dart';
import 'package:flutter/material.dart';

class AddUpdatePage extends StatefulWidget {
  const AddUpdatePage({super.key});

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController titreController = TextEditingController();
  final TextEditingController auteurController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController publicationyearController = TextEditingController();
  final TextEditingController resumeController = TextEditingController();
  
  Future<void>saveBook() async {
    if (_formKey.currentState!.validate()){
      final newBook = Book(
        titre: titreController.text, 
        auteur: auteurController.text, 
        genre: genreController.text, 
        publicationYear:int.tryParse(publicationyearController.text)??0, 
        resume: resumeController.text,
        );

        await BookDatabase.instance.create(newBook);
        Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bibliotèque"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titreController,
                decoration: InputDecoration(labelText: "Titre"),
                validator: (value) => value == null || value.isEmpty? "Ce champ est requi":null,
              ),
              TextFormField(
                controller: auteurController,
                decoration: InputDecoration(labelText: "Auteur"),
                validator: (value) => value == null || value.isEmpty? "Ce champ est requi":null,
              ),
              TextFormField(
                controller: genreController,
                decoration: InputDecoration(labelText: "Genre"),
                validator: (value) => value == null || value.isEmpty? "Ce champ est requi":null,
              ),
              TextFormField(
                controller: publicationyearController,
                decoration: InputDecoration(labelText: "Année de publication"),
                validator: (value) => value == null || value.isEmpty? "Ce champ est requi":null,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: resumeController,
                decoration: InputDecoration(labelText: "Titre"),
                validator: (value) => value == null || value.isEmpty? "Ce champ est requi":null,
                maxLines: 3,
              ),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: saveBook, child: Text("Enrégistrer"))
            ],
          )
          ),
        ),
      
    );
  }
}