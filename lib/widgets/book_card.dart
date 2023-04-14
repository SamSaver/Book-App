import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/user.dart';
import '../views/book_details.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book, required this.user});

  final MyUser user;
  final Book book;

  String trimString(String str, int threshold) {
    if (str.length > threshold) {
      return '${str.substring(0, threshold)} ...';
    } else {
      return str;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetails(
                      book: book,
                      user: user,
                    )));
      },
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network(
                  book.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    trimString(book.title, 27),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  trimString(book.author, 14),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(245, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Rating: ${book.rating}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(201, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
