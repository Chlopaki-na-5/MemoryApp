import 'package:flutter/material.dart';
import '../game/game_board.dart';
import '../screens/options_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _numberOfPlayers = 1;
  int _roundTime = 60;

  void _navigateToGameBoard(BuildContext context, int rows, int columns) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameBoard(
          rows: rows,
          columns: columns,
          numberOfPlayers: _numberOfPlayers,
          roundTime: _roundTime,
        ),
      ),
    );
  }

  Future<void> _navigateToOptions(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OptionsScreen()),
    );

    if (result != null && result is Map<String, int>) {
      setState(() {
        _numberOfPlayers = result['players']!;
        _roundTime = result['time']!;
      });
    }
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
            _navigateToOptions(context);
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
                    _navigateToGameBoard(context, 3, 4);
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
                      '3x3',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                ElevatedButton(
                  onPressed: () {
                    _navigateToGameBoard(context, 4, 4);
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
