import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory app',
      theme: ThemeData(
        fontFamily: 'Arial',
      ),
      home: const MyHomePage(title: 'Memory App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _navigateToGameBoard(BuildContext context, int gridSize) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameBoard(gridSize: gridSize)),
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
            // TODO options
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

class GameBoard extends StatelessWidget {
  final int gridSize;

  const GameBoard({super.key, required this.gridSize});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$gridSize x $gridSize Game Board'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double cardSize = (constraints.maxWidth - (gridSize - 1) * 10) / gridSize;

          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridSize,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: gridSize * gridSize,
            itemBuilder: (context, index) {
              return Container(
                width: cardSize,
                height: cardSize,
                color: Colors.blueAccent,
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
