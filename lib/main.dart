import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'new flutter',
      theme: new ThemeData(
        primaryColor:  Colors.white,
      ),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  void _pushSaved(){
    ///路由点击事件
    Navigator.of(context).push(
      //创建页面路由对象
      new MaterialPageRoute(
        builder: (context){
          final tiles = _saved.map((pair){
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style:_biggerFont,
              )
            );
          },
        );
          final divided = ListTile
          .divideTiles(
            context: context,
            tiles: tiles,
          )
          .toList();
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('RouterPage'),

            ),
            body: new ListView(
              children: divided,
            )
          );
        }
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // 存放单词的列表
    // final wordPair = new WordPair.random();
    // //修改界面的大小
    // return new Text(wordPair.asPascalCase);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('GKD GKD'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buidSuggestions(),
    );
  }

  Widget _buidSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: new Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null
            ),
            onTap: (){
              setState(() {
               if(alreadySaved){
                 _saved.remove(pair);
               } else {
                 _saved.add(pair);
               }
              });
            },);
        
  }
}
