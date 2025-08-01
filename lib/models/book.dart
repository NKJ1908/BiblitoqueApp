/// Modèle représentant un livre
class Book {
  final int? id;
  final String titre;
  final String auteur;
  final String genre;
  final int publicationYear;
  final String resume;

  Book({
    this.id,
    required this.titre,
    required this.auteur,
    required this.genre,
    required this.publicationYear,
    required this.resume,
    });
/// Convertir un objet livre en map pour SQLite
    Map<String, dynamic> toMap(){
      return {
        'id': id,
        'titre': titre,
        'auteur': auteur,
        'genre': genre,
        'publicationYear': publicationYear,
        'resume': resume,
      };
    }
/// Reconversion d'un map récupérer depuis la base de donnée en objet livre
    factory Book.fromMap(Map<String,dynamic>map){
      return Book(
        id : map['id'],
        titre: map['titre'],
        auteur: map['auteur'],
        genre: map['genre'],
        publicationYear: map['publicationYear'],
        resume: map['resume'],
      );
    }
}