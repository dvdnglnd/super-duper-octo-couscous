// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String selection = 'sup';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'เสียงพระเจ้า',
        home: Scaffold(
            appBar: AppBar(
                title: Center(
              child: Text('พระเสียงพระเจ้า'),
            )),
            body: Container(padding: EdgeInsets.all(20), child: Selector())));
  }
}

class Selector extends StatefulWidget {
  @override
  _SelectorState createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  String _book = 'Matthew';
  int _chapter = 1;
  bool _playing = false;
  IconData _icon = Icons.play_arrow;

  void _handleBookChange(String newBook) {
    setState(() {
      _book = newBook;
    });
  }

  void _handleChapterChange(int newChapter) {
    setState(() {
      _chapter = newChapter;
    });
  }

  void _handlePlayingChange() {
    setState(() {
      _playing = !_playing;
      _icon = _playing ? Icons.pause : Icons.play_arrow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 150.0,
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: BookSelector(
            book: _book,
            chapter: _chapter,
            onBookChanged: _handleBookChange,
            onChapterChanged: _handleChapterChange,
          ),
        ),
        Container(
            height: 200.0,
            width: 200.0,
            padding: EdgeInsets.all(10),
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  _handlePlayingChange();
                },
                child: Icon(_icon),
                backgroundColor: Colors.lightBlue,
              ),
            )),
      ],
    );
  }
}

class BookSelector extends StatelessWidget {
  BookSelector(
      {Key? key,
      this.book: 'Matthew',
      this.chapter: 1,
      required this.onBookChanged,
      required this.onChapterChanged})
      : super(key: key);

  final String book;
  final int chapter;
  final ValueChanged<String> onBookChanged;
  final ValueChanged<int> onChapterChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButton<String>(
                  value: book,
                  icon: const Icon(Icons.book),
                  iconSize: 24,
                  elevation: 16,
                  dropdownColor: Colors.lightBlueAccent,
                  style: TextStyle(
                    fontSize: 30
                  ),
                  onChanged: (String? newValue) {
                    onBookChanged(newValue!);
                  },
                  items: <String>['Matthew', 'Mark', 'Luke', 'John']
                      .map<DropdownMenuItem<String>>((String value) =>
                          DropdownMenuItem(value: value, child: Text(value)))
                      .toList())),
          Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButton<int>(
                  value: chapter,
                  icon: const Icon(Icons.book),
                  iconSize: 24,
                  elevation: 16,
                  dropdownColor: Colors.lightBlueAccent,
                  style: TextStyle(
                      fontSize: 30
                  ),
                  onChanged: (int? newValue) {
                    onChapterChanged(newValue!);
                  },
                  items: <int>[1, 2, 3, 4, 5]
                      .map<DropdownMenuItem<int>>((int value) =>
                          DropdownMenuItem(
                              value: value, child: Text(value.toString())))
                      .toList()))
        ]);
  }
}
