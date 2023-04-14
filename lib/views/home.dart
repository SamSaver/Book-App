import 'package:books_app/views/favourite.dart';
import 'package:books_app/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../models/user.dart';
import '../services/auth.dart';
import '../models/book.dart';
import '../services/helper.dart';
import '../widgets/book_card.dart';
import '../widgets/search_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.user});

  final MyUser user;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool switchValue = false;
  bool loading = true;
  String searchText = '';
  Color toggleColor = Colors.black;
  List<Book> books = <Book>[];

  void searchTextHandler(String val) async {
    setState(() {
      loading = true;
    });

    dynamic docs;

    if (switchValue) {
      docs = await fetchBookByAuthor(val);
    } else {
      docs = await fetchBookByName(val);
    }

    setState(() {
      books = docs;
      loading = false;
      searchText = '';
    });
  }

  @override
  void initState() {
    super.initState();

    fetchNBooks(20).then((value) {
      setState(() {
        books = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bottom Navigation Bar
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Favourite(user: widget.user)));
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
          padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
          child: Column(
            children: [
              SearchBar(searchTextHandler: searchTextHandler),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: FlutterSwitch(
                  width: 100,
                  height: 30,
                  toggleSize: 40,
                  toggleColor: toggleColor,
                  activeColor: (Colors.amber[900])!,
                  inactiveColor: (Colors.amber[100])!,
                  value: switchValue,
                  onToggle: (val) {
                    setState(() {
                      switchValue = val;
                    });
                  },
                  activeIcon:
                      const Icon(Icons.person, size: 8, color: Colors.amber),
                  inactiveIcon:
                      const Icon(Icons.book, size: 8, color: Colors.amber),
                ),
              ),
              loading
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Flexible(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          childAspectRatio: 0.55,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (_, index) => BookCard(
                          book: books[index],
                          user: widget.user,
                        ),
                        itemCount: books.length,
                      ),
                    ),
            ],
          ),
        ),
      ]),
    );
  }
}
