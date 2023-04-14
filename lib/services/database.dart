import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/book.dart';

class DatabaseService {
  Future<int> removeFavouriteBook(Book book, String userId) async {
    var result = -1;

    // Checking whether the book is already in the favourites list
    // If it is already there then remove it from the favourites list
    // If it is not there then return a proper message
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection("Favourites")
        .where("bookId", isEqualTo: book.id)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        result = -1;
      } else {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userId)
            .collection("Favourites")
            .doc(book.id)
            .delete()
            .catchError((e) => {print(e.toString())});

        result = 1;
      }
    }).catchError((e) => {print(e.toString())});

    return result;
  }

  Future<int> addFavouriteBook(Book book, String userId) async {
    // Checking whether the book is already in the favourites list
    // If it is already there then return a proper message
    // If it is not there then add it to the favourites list
    var result = 0;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection("Favourites")
        .where("bookId", isEqualTo: book.id)
        .get()
        .then((value) async {
      if (value.docs.length == 0) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userId)
            .collection("Favourites")
            .doc(book.id)
            .set({
          "bookId": book.id,
          "bookTitle": book.title,
          "bookAuthor": book.author,
          "bookPublisher": book.publisher,
          "bookDescription": book.description,
          "bookImageUrl": book.imageUrl,
          "bookRating": book.rating,
          "bookNumberOfPages": book.numberOfPages,
        }).catchError((e) => {print(e.toString())});

        result = 1;
      } else {
        result = -1;
      }
    }).catchError((e) => {print(e.toString())});

    return result;
  }

  getFavouriteData(String userId) async {
    // print('Got user id: $userId');
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection('Favourites')
        .snapshots();
  }

  // getQuestionData(String quizId) async {
  //   return await FirebaseFirestore.instance
  //       .collection("Quiz")
  //       .doc(quizId)
  //       .collection("QNA")
  //       .get();
  // }
}
