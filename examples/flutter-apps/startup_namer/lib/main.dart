import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();

    return MaterialApp(
      title: 'Startup Name Gen',
      home: RandomWords(),
        /*appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          //child: Text('Hello World'),
          //child: Text(wordPair.asPascalCase),
          child: RandomWords(),
        ),
      ),*/
    );
  }
}

class RandomWordsState extends State {
  // TODO Add build() method
  final _suggestions = <WordPair>[];
  final Set<WordPair> _savedWordPairs = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list), onPressed: _pushSaved
          ),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            final Iterable<ListTile> tiles = _savedWordPairs.map(
                (WordPair pair) {
                  return new ListTile(
                    title: new Text(
                      pair.asPascalCase,
                      style: _biggerFont,
                    ),
                  );
                }
            );
            final List<Widget> divided = ListTile
                .divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList();
            return new Scaffold(
              appBar: new AppBar(
                title: const Text('Saved Suggestions'),
              ),
              body: new ListView(children: divided),
            );
          },
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
       padding: const EdgeInsets.all(16.0),
       itemBuilder: (context, i) {
         if (i.isOdd) return Divider();

         final index = i ~/ 2;
         if (index >= _suggestions.length) {
           _suggestions.addAll(generateWordPairs().take(10));
         }
         return _buildRow(_suggestions[index]);
       }
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final bool alreadySaved = _savedWordPairs.contains(wordPair);

    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordPairs.remove(wordPair);
          } else {
            _savedWordPairs.add(wordPair);
          }
        });
      },
    );
  }

/*Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }*/
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
