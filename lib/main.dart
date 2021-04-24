// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        title: 'พระคัมภีร์เรียบง่าย',
        home: Scaffold(
            appBar: AppBar(
                title: Center(
              child: Text('พระคัมภีร์เรียบง่าย'),
            )),
            body: Container(padding: EdgeInsets.all(20), child: Selector())));
  }
}

class Selector extends StatefulWidget {
  @override
  _SelectorState createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  static BibleData _bibleData = BibleData();
  String _book = _bibleData.books[0];
  int _chapter = 1;
  int _maxChapter = _bibleData.chapters[_bibleData.books[0]]!;
  bool _playing = false;
  IconData _icon = Icons.play_arrow;
  static AudioPlayer _audioPlayer = AudioPlayer();
  static AudioCache _audioCache =
      AudioCache(prefix: 'assets/audios/', fixedPlayer: _audioPlayer);

  void _handleBookChange(String newBook) {
    setState(() {
      _book = newBook;
      _maxChapter = _bibleData.chapters[_book]!;
      _chapter = 1;
      if (_playing) _handlePlayingChange();
    });
  }

  void _handleChapterChange(int newChapter) {
    setState(() {
      _chapter = newChapter;
      if (_playing) _handlePlayingChange();
    });
  }

  String addZero(int) {
    return int < 10 ? "0" + int.toString() : int.toString();
  }

  String makeFileName() {
    return "B" +
        addZero(_bibleData.books.indexOf(_book) + 1) +
        "___" +
        addZero(_chapter) +
        ".mp3";
  }

  void _handlePlayingChange() {
    setState(() {
      _playing = !_playing;
      _playing ? _audioCache.play(makeFileName()) : _audioPlayer.pause();
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
            books: _bibleData.books,
            chapters: _bibleData.chapters,
            book: _book,
            chapter: _chapter,
            maxChapter: _maxChapter,
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
      required this.books,
      required this.chapters,
      required this.book,
      this.chapter: 1,
      required this.maxChapter,
      required this.onBookChanged,
      required this.onChapterChanged})
      : super(key: key);

  final String book;
  final int chapter;
  final int maxChapter;
  final List<String> books;
  final Map<String, int> chapters;
  final ValueChanged<String> onBookChanged;
  final ValueChanged<int> onChapterChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 4,
        runSpacing: 4,
        alignment: WrapAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButton<String>(
                  value: book,
                  iconSize: 36,
                  elevation: 16,
                  dropdownColor: Colors.lightBlueAccent,
                  style: TextStyle(fontSize: 24),
                  onChanged: (String? newValue) {
                    onBookChanged(newValue!);
                  },
                  items: books
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
                  iconSize: 36,
                  elevation: 16,
                  dropdownColor: Colors.lightBlueAccent,
                  style: TextStyle(fontSize: 20),
                  onChanged: (int? newValue) {
                    onChapterChanged(newValue!);
                  },
                  items: [for (var i = 1; i <= maxChapter; i += 1) i]
                      .map<DropdownMenuItem<int>>((int value) =>
                          DropdownMenuItem(
                              value: value, child: Text(value.toString())))
                      .toList()))
        ]);
  }
}

class BibleData {
  final List<String> books = jsonData.keys.toList();
  final Map<String, int> chapters = jsonData;
}

const jsonData = {
  "มัทธิว": 28,
  "มาระโก": 16,
  "ลูกา": 24,
  "ยอห์น": 21,
  "กิจการ": 28,
  "โรม": 16,
  "1 โครินธ์": 16,
  "2 โครินธ์": 13,
  "กาลาเทีย": 6,
  "เอเฟซัส": 6,
  "ฟิลิปปี": 4,
  "โคโลสี": 4,
  "1 เธสะโลนิกา": 5,
  "2 เธสะโลนิกา": 3,
  "1 ทิโมธี": 6,
  "2 ทิโมธี": 4,
  "ทิตัส": 3,
  "ฟีเลโมน": 1,
  "ฮีบรู": 13,
  "ยากอบ": 5,
  "1 เปโตร": 5,
  "2 เปโตร": 3,
  "1 ยอห์น": 5,
  "2 ยอห์น": 1,
  "3 ยอห์น": 1,
  "ยูดา": 1,
  "วิวรณ์": 22
};
