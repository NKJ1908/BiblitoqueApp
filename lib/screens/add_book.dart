import 'package:biblioteque/db/book_database.dart';
import 'package:biblioteque/models/book.dart';
import 'package:biblioteque/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AddUpdatePage extends StatefulWidget {
  final Book? book;
  const AddUpdatePage({super.key,this.book});


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

  @override
  void initState(){
    super.initState();

    if (widget.book != null){
      titreController.text = widget.book!.titre;
      auteurController.text = widget.book!.auteur;
      genreController.text = widget.book!.genre;
      publicationyearController.text = widget.book!.publicationYear.toString();
      resumeController.text = widget.book!.resume;

    }
  }
  
  Future<void>saveBook() async {
    if (_formKey.currentState!.validate()){
      final bookToSave = Book(
        id: widget.book?.id,
        titre: titreController.text, 
        auteur: auteurController.text, 
        genre: genreController.text, 
        publicationYear:int.tryParse(publicationyearController.text)??0, 
        resume: resumeController.text,
        );
    if (widget.book == null){
      await BookDatabase.instance.create(bookToSave);
    }else{
      await BookDatabase.instance.update(bookToSave);
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(widget.book == null
    ?"Livre ajoutée avec succès"
    :"Livre mis à jour"),
    duration: Duration(seconds: 3),));
        
    Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(
        builder: (_)=> const HomePage()),
        (Route) => false
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.book != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Modifier le livre":"Ajouter un livre"),
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
                decoration: InputDecoration(labelText: "Titre",border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty? "Ce champ est requis":null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: auteurController,
                decoration: InputDecoration(labelText: "Auteur",border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty? "Ce champ est requis":null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: genreController,
                decoration: InputDecoration(labelText: "Genre",border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty? "Ce champ est requis":null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: publicationyearController,
                decoration: InputDecoration(labelText: "Année de publication",border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty? "Ce champ est requis":null,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: resumeController,
                decoration: InputDecoration(labelText: "Résumé",border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty? "Ce champ est requis":null,
                maxLines: 3,
              ),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: saveBook, child: Text(isEditing ? "Mettre à jour":"Enrégistrer"))
            ],
          )
          ),
        ),
      
    );
  }
}