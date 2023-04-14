import 'package:books_app/views/signin.dart';
import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/user.dart';
import '../services/auth.dart';
import '../services/database.dart';
import '../widgets/book_card.dart';
import 'home.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key, required this.user});

  final MyUser user;

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final favourites = [];
  bool loading = true;
  late Stream favouriteStream;

  @override
  void initState() {
    DatabaseService databaseService = DatabaseService();
    // Get current user Id using Provider
    databaseService.getFavouriteData(widget.user.uid).then((value) {
      favouriteStream = value;

      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
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
            if (index == 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(user: widget.user)));
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : StreamBuilder(
                      stream: favouriteStream,
                      builder: (context, snapshot) {
                        return snapshot.data == null
                            ? const Center(child: CircularProgressIndicator())
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 220,
                                  childAspectRatio: 0.55,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  Book book = Book.fromMap(
                                      snapshot.data.docs[index].data());
                                  return BookCard(
                                    book: book,
                                    user: widget.user,
                                  );
                                });
                      },
                    ))
        ]));
  }
}
