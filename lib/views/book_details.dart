import 'package:books_app/services/database.dart';
import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/user.dart';
import '../services/auth.dart';
import 'favourite.dart';
import 'signin.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key, required this.book, required this.user});

  final Book book;
  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Favourite(user: user)));
          } else if (index == 2) {
            // Logout
            final authService = AuthService();
            authService.signOut(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignIn()));
          }
        },
      ),
      body: Stack(fit: StackFit.expand, children: [
        const Image(
          image: AssetImage('assets/book.jpg'),
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
          color: Colors.black54,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: ListView(
            children: [
              Image.network(book.imageUrl, height: 200, width: 200),
              const SizedBox(height: 20),
              Text(
                book.title,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Author: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.amber,
                      ),
                    ),
                    TextSpan(
                      text: book.author,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Publisher: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.amber,
                      ),
                    ),
                    TextSpan(
                      text: book.publisher,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                book.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Rating: ',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.amber),
                    ),
                    TextSpan(
                      text: book.rating.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Pages: ',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.amber),
                    ),
                    TextSpan(
                      text: book.numberOfPages.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    )),
                child: const Text('Go Back'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  DatabaseService db = DatabaseService();
                  await db.addFavouriteBook(book, user.uid).then((value) {
                    print('Value is ${value}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: value == 1
                            ? const Text('Book added to favourites')
                            : const Text('Book already in favourites'),
                      ),
                    );
                  });
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    )),
                child: const Text('Add to Favourites'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  DatabaseService db = DatabaseService();
                  await db.removeFavouriteBook(book, user.uid).then((value) {
                    print('Value is ${value}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: value == 1
                            ? const Text('Book removed from favourites')
                            : const Text('Book is not in favourites'),
                      ),
                    );
                  });
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    )),
                child: const Text('Remove from Favourites'),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
