import 'package:flutter/material.dart';
import 'dart:async';
import '../models/memory_card.dart';
import '../game/memory_game.dart';

class GameBoard extends StatefulWidget {
  final int gridSize;
  final int numberOfPlayers;
  final int roundTime;

  const GameBoard({
    super.key,
    required this.gridSize,
    required this.numberOfPlayers,
    required this.roundTime,
  });

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late MemoryGame _memoryGame;
  late Timer _timer;
  late int _timeRemaining;
  int _currentPlayer = 0;
  List<int> _pairScores = [];
  List<int> _timeBonuses = [];
  bool _isGameFinished = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _memoryGame = MemoryGame(gridSize: widget.gridSize);
    _timeRemaining = widget.roundTime;
    _currentPlayer = 0;
    _pairScores = List.generate(widget.numberOfPlayers, (_) => 0);
    _timeBonuses = List.generate(widget.numberOfPlayers, (_) => 0);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _timer.cancel();
        _endRound();
      }
    });
  }

  void _onCardTapped(MemoryCard card) async {
    if (_timeRemaining > 0) {
      setState(() {});
      await _memoryGame.selectCard(card);
      setState(() {});

      if (_memoryGame.isPairFound) {
        _pairScores[_currentPlayer] += 10;
      }

      if (_memoryGame.isGameOver) {
        _timer.cancel();
        _addTimeBonus();
        _endRound();
      }
    }
  }

  void _addTimeBonus() {
    if (_timeRemaining > 0) {
      _timeBonuses[_currentPlayer] = _timeRemaining;
    }
  }

  void _endRound() {
    setState(() {
      _addTimeBonus();
      _currentPlayer++;
      if (_currentPlayer < widget.numberOfPlayers) {
        _memoryGame.resetGame();
        _timeRemaining = widget.roundTime;
        _startTimer();
      } else {
        _isGameFinished = true;
      }
    });
  }

  Widget _buildResultsTable() {

    List<Map<String, dynamic>> results = List.generate(widget.numberOfPlayers, (index) {

      int pairScore = _pairScores[index];
      int timeBonus = _timeBonuses[index];
      int totalScore = pairScore + timeBonus;
      return {
        'player': 'Gracz ${index + 1}',
        'pairScore': pairScore,
        'timeBonus': timeBonus,
        'totalScore': totalScore,
      };
    });

    // Sort results by total score in descending order
    results.sort((a, b) => b['totalScore'].compareTo(a['totalScore']));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Gracz')),
          DataColumn(label: Text('Punkty za pary')),
          DataColumn(label: Text('Punkty za czas')),
          DataColumn(label: Text('Suma punktów')),
        ],
        rows: results.map((result) {
          return DataRow(
            cells: [
              DataCell(Text(result['player'])),
              DataCell(Text(result['pairScore'].toString())), // Punkty za pary
              DataCell(Text(result['timeBonus'].toString())), // Punkty za czas
              DataCell(Text(result['totalScore'].toString())), // Suma punktów
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('${widget.gridSize} x ${widget.gridSize} Game Board'),
        backgroundColor: Color(0xffbeb4ff),
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
        child: _isGameFinished
            ? Center(child: _buildResultsTable())
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Czas: $_timeRemaining sek', style: const TextStyle(fontSize: 24)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Gracz: ${_currentPlayer + 1}', style: const TextStyle(fontSize: 24)),
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double cardSize = (constraints.maxWidth - (widget.gridSize - 1) * 10) / widget.gridSize;

                  return GridView.builder(

                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.gridSize,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: widget.gridSize * widget.gridSize,
                    itemBuilder: (context, index) {
                      MemoryCard card = _memoryGame.cards[index];
                      return GestureDetector(
                        onTap: () => _onCardTapped(card),
                        child: Container(
                          width: cardSize,
                          height: cardSize,
                          decoration: BoxDecoration(
                            color: card.isFaceUp ? Colors.white : Colors.blue,
                            borderRadius: BorderRadius.circular(8.0),
                            image: card.isFaceUp
                                ? DecorationImage(
                              image: AssetImage(card.imageAssetPath),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child: card.isFaceUp
                              ? null
                              : Center(
                            child: Text(
                              '?',
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
