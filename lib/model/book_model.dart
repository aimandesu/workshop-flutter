// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookModel {
  final int? id;
  final String isbn;
  final String name;
  final int year;
  final String author;
  final String description;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  BookModel({
    this.id,
    required this.isbn,
    required this.name,
    required this.year,
    required this.author,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  BookModel copyWith({
    int? id,
    String? isbn,
    String? name,
    int? year,
    String? author,
    String? description,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookModel(
      id: id ?? this.id,
      isbn: isbn ?? this.isbn,
      name: name ?? this.name,
      year: year ?? this.year,
      author: author ?? this.author,
      description: description ?? this.description,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory BookModel.initial() {
    return BookModel(
      id: 0,
      isbn: '',
      name: '',
      year: 0,
      author: '',
      description: '',
      image: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isbn': isbn,
      'name': name,
      'year': year,
      'author': author,
      'description': description,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] as int,
      isbn: map['isbn'] as String,
      name: map['name'] as String,
      year: map['year'] as int,
      author: map['author'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      createdAt:
          DateTime.parse(map["createdAt"] as String), // Parse to DateTime
      updatedAt:
          DateTime.parse(map["updatedAt"] as String), // Parse to DateTime
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookModel(id: $id, isbn: $isbn, name: $name, year: $year, author: $author, description: $description, image: $image, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant BookModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.isbn == isbn &&
        other.name == name &&
        other.year == year &&
        other.author == author &&
        other.description == description &&
        other.image == image &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        isbn.hashCode ^
        name.hashCode ^
        year.hashCode ^
        author.hashCode ^
        description.hashCode ^
        image.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
