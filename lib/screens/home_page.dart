import 'package:flutter/material.dart';
import '../game/game_board.dart';
import 'settings_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _roundTime = 60;
  int _numberOfPlayers = 2;

  void _navigateToGameBoard(BuildContext context, int gridSize) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameBoard(
          gridSize: gridSize,
          roundTime: _roundTime,
          numberOfPlayers: _numberOfPlayers,
        ),
      ),
    );
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(
          onSettingsChanged: (roundTime, numberOfPlayers) {
            setState(() {
              _roundTime = roundTime;
              _numberOfPlayers = numberOfPlayers;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 47,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.settings,
            size: 32,
          ),
          onPressed: () {
            _navigateToSettings(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffbeb4ff),
              Color(0xffb4efff),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Wybierz poziom trudności',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _navigateToGameBoard(context, 4);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffb298ff),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: const Size(120, 120),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '4x4',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                ElevatedButton(
                  onPressed: () {
                    _navigateToGameBoard(context, 8);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffb298ff),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: const Size(120, 120),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '8x8',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
