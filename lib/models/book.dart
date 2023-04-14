import 'package:flutter/material.dart';

class Book {
  String title;
  String author;
  String publisher;
  String description;
  String imageUrl;
  String id;
  num rating;
  num numberOfPages;

  Book(
      {required this.title,
      required this.author,
      required this.publisher,
      required this.description,
      required this.imageUrl,
      required this.id,
      required this.rating,
      required this.numberOfPages});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['volumeInfo']['title'] ?? 'Title Not Found',
      rating: json['volumeInfo']['averageRating'] ?? 0.0,
      publisher: json['volumeInfo']['publisher'] ?? 'Publisher Not Found',
      numberOfPages: json['volumeInfo']['pageCount'] ?? 0,
      description: json['volumeInfo']['description'] ?? 'Description Not Found',
      imageUrl: json['volumeInfo']['imageLinks']?.isNotEmpty == true
          ? json['volumeInfo']['imageLinks']['thumbnail']
          : 'https://picsum.photos/200/300',
      id: json['id'] ?? 'ID Not Found',
      author: json['volumeInfo']['authors']?.isNotEmpty == true
          ? json['volumeInfo']['authors'][0]
          : 'Author Not Found',
    );
  }

  factory Book.fromMap(Map<String, dynamic> snapshot) {
    return Book(
        title: snapshot['bookTitle'],
        author: snapshot['bookAuthor'],
        publisher: snapshot['bookPublisher'],
        description: snapshot['bookDescription'],
        imageUrl: snapshot['bookImageUrl'],
        id: snapshot['bookId'],
        rating: snapshot['bookRating'],
        numberOfPages: snapshot['bookNumberOfPages']);
  }
}
