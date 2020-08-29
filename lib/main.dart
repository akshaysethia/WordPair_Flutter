import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

final savedWordPairs = Set<WordPair>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.red[300],
        primaryColor: Colors.black,
        canvasColor: Colors.black,
      ),
    );
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Word Pair",
          style: TextStyle(color: Colors.red[300]),
        ),
        titleSpacing: 3,
        elevation: 10,
        leading: Padding(
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundColor: Colors.red[300],
              child: Image.asset(
                "assets/emoji.png",
              ),
            )),
        actions: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                icon: Icon(
                  Icons.bookmark_border,
                  color: Colors.red[300],
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FavouritePage()));
                },
              ))
        ],
      ),
      body: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final wordPairs = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20.0),
      itemBuilder: (context, index) {
        if (index.isOdd)
          return Divider(
            color: Colors.white70,
            indent: 3,
            thickness: 3,
          );

        final item = index ~/ 2;

        if (item >= wordPairs.length) {
          wordPairs.addAll(generateWordPairs().take(10));
        }

        final alreadySaved = savedWordPairs.contains(wordPairs[item]);

        return Card(
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "assets/next.png",
                color: Colors.black,
              ),
            ),
            title: Text(
              wordPairs[item].asPascalCase,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : Colors.black),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  savedWordPairs.remove(wordPairs[item]);
                } else {
                  savedWordPairs.add(wordPairs[item]);
                }
              });
            },
          ),
          color: Colors.deepPurple[300],
        );
      },
    );
  }
}

class FavouritePage extends StatelessWidget {
  final wordList = savedWordPairs.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Favourite Pairs",
          style: TextStyle(color: Colors.red[300]),
        ),
        titleSpacing: 3,
        elevation: 10,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(20.0),
          itemCount: savedWordPairs.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/heart.png",
                    color: Colors.red[400],
                  ),
                ),
                title: Text(
                  wordList[index].asPascalCase,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              color: Colors.deepPurple[300],
            );
          }),
    );
  }
}
