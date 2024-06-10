import 'package:flutter/material.dart';
import 'dart:async';
import '../models/memory_card.dart';
import '../game/memory_game.dart';

class GameBoard extends StatefulWidget {
  final int columns;
  final int rows;
  final int numberOfPlayers;
  final int roundTime;

  const GameBoard({
    super.key,
    required this.rows,
    required this.columns,
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
    _memoryGame = MemoryGame(rows: widget.rows, columns: widget.columns);
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

    return DataTable(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${widget.columns} x ${widget.rows} Game Board'),
        backgroundColor: Colors.transparent,
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
                  double cardWidth = (constraints.maxWidth - (widget.columns - 1) * 10) / widget.columns;
                  double cardHeight = (constraints.maxHeight - (widget.rows - 1) * 10) / widget.rows;

                  return GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.columns,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: widget.rows * widget.columns,
                    itemBuilder: (context, index) {
                      MemoryCard card = _memoryGame.cards[index];

                      return GestureDetector(
                        onTap: () => _onCardTapped(card),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: cardWidth,
                          height: cardHeight,
                          transform: card.isMatched ? (Matrix4.identity()..scale(0.9)) : Matrix4.identity(),
                          decoration: BoxDecoration(
                            color: card.isFaceUp || card.isMatched ? Colors.blueAccent : Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              card.isFaceUp || card.isMatched ? card.content : '',
                              style: const TextStyle(fontSize: 24, color: Colors.white),
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
