import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(new MaterialApp(
    home: RandomWordsState(),
  ));
}

class RandomWordsState extends StatefulWidget {
  // comando que nos permite fazer trocas de palavras
  @override
  _RandomWordsStateState createState() => _RandomWordsStateState();
}

class _RandomWordsStateState extends State<RandomWordsState> {
  final _sugestoes = <WordPair>[];
  final _seved = new Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Lista Infinita"),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.list), onPressed: _pusSaved)
        ],
      ),
      body: _buildSugestao(),
    );
  }

  void _pusSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _seved.map((pair) {
        return new ListTile(
          title: Text(pair.asPascalCase),
        );
      });

      final divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Guardadas"),
        ),
        body: new ListView(
          children: divided,
        ),
      );
    }));
  }

  Widget _biulRons(WordPair pair) {
    final bool alreadSaved = _seved.contains(pair);

    for (var item in _seved) {
      print(item);
    }
    return new ListTile(
      title: Text(
        // para colocar a primeira palavra maiuscula
        pair.asPascalCase,
      ),
      trailing: new Icon(alreadSaved ? Icons.favorite : Icons.favorite_border,
          color: Colors.redAccent),
      // metodo para salvar
      onTap: () {
        setState(() {
          if (alreadSaved) {
            _seved.remove(pair);
          } else {
            _seved.add(pair);
          }
        });
      },
    );
  }

  Widget _buildSugestao() {
    return new ListView.builder(
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();
        // vai difinir a posição de cada umas das listas
        final index = i ~/ 2;

        if (index >= _sugestoes.length) {
          _sugestoes.addAll(generateWordPairs().take(10));
        }
        return _biulRons(_sugestoes[index]);
      },
    );
  }
}
