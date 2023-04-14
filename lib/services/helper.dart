import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/book.dart';

fetchNBooks(N) async {
  final response = await http.get(Uri.parse(
      'https://www.googleapis.com/books/v1/volumes?q=subject:fantasy&startIndex=0&maxResults=$N'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final docs = data['items'];

    // print('Length of docs: ${docs.length}');
    // print('First book: ${docs[0]!['volumeInfo']['title']}');

    final result = (docs as List).map((e) => Book.fromJson(e)).toList();
    return result;
  } else {
    // print('Request failed with status: ${response.statusCode}.');
  }
}
// https://www.googleapis.com/books/v1/volumes?q=subject:fantasy

fetchBookByName(bookName) async {
  // convert bookName string with spaces to + signs
  bookName = bookName.replaceAll(' ', '+');
  final response = await http.get(Uri.parse(
      'https://www.googleapis.com/books/v1/volumes?q=$bookName&startIndex=0&maxResults=40'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final docs = data['items'];

    final result = (docs as List).map((e) => Book.fromJson(e)).toList();

    return result;
  } else {
    // print('Request failed with status: ${response.statusCode}.');
  }
}

fetchBookByAuthor(authorName) async {
  // convert authorName string with spaces to + signs
  authorName = authorName.replaceAll(' ', '+');
  final response = await http.get(Uri.parse(
      'https://www.googleapis.com/books/v1/volumes?q=inauthor:$authorName&startIndex=0&maxResults=40'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final docs = data['items'];

    final result = (docs as List).map((e) => Book.fromJson(e)).toList();

    return result;
  } else {
    // print('Request failed with status: ${response.statusCode}.');
  }
}



// https://www.googleapis.com/books/v1/volumes?q=the+lord+of+the+rings&startIndex=0&maxResults=20
