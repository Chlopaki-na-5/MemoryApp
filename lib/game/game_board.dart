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
  List<int> _scores = [];
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
    _scores = List.generate(widget.numberOfPlayers, (_) => 0);
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
        _scores[_currentPlayer] += 10;
      }

      if (_memoryGame.isGameOver) {
        _timer.cancel();
        _addTimeBonus();
        _endGame();
      }
    }
  }

  void _addTimeBonus() {
    if (_memoryGame.isGameOver && _timeRemaining > 0) {
      _scores[_currentPlayer] += _timeRemaining;
    }
  }

  void _endRound() {
    setState(() {
      _currentPlayer = (_currentPlayer + 1) % widget.numberOfPlayers;
      if (_currentPlayer == 0) {
        _isGameFinished = true;
      } else {
        _memoryGame.resetGame();
        _timeRemaining = widget.roundTime;
        _startTimer();
      }
    });
  }

  void _endGame() {
    setState(() {
      _isGameFinished = true;
    });
  }

  Widget _buildResultsTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Gracz')),
        DataColumn(label: Text('Punkty za pary')),
        DataColumn(label: Text('Punkty za czas')),
        DataColumn(label: Text('Suma punktów')),
      ],
      rows: List<DataRow>.generate(
        widget.numberOfPlayers,
            (index) {
          int timeBonus = 0;
          int totalScore = _scores[index] + timeBonus;
          return DataRow(
            cells: [
              DataCell(Text('Gracz ${index + 1}')),
              DataCell(Text((_scores[index] - _timeRemaining).toString())), // Punkty za pary
              DataCell(Text(timeBonus.toString())), // Punkty za czas
              DataCell(Text(totalScore.toString())), // Suma punktów
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          '${widget.gridSize} x ${widget.gridSize} Game Board',
          style: const TextStyle(
            fontSize: 24,
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
            Icons.arrow_back,
            size: 32,
          ),
          onPressed: () {
            Navigator.pop(context);
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
        child: _isGameFinished
            ? Center(child: _buildResultsTable())
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Text('Czas: $_timeRemaining sek', style: TextStyle(fontSize: 24)),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text('Gracz: ${_currentPlayer + 1}', style: TextStyle(fontSize: 24)),
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
