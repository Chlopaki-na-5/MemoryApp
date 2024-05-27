import 'package:flutter/material.dart';
import 'dart:async';
import '../models/memory_card.dart';
import '../game/memory_game.dart';

class GameBoard extends StatefulWidget {
  final int gridSize;
  final int roundTime;
  final int numberOfPlayers;

  const GameBoard({
    Key? key,
    required this.gridSize,
    required this.roundTime,
    required this.numberOfPlayers,
  }) : super(key: key);

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late MemoryGame _memoryGame;
  int _currentPlayer = 0;
  int _remainingTime = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _memoryGame = MemoryGame(gridSize: widget.gridSize);
    _startRound();
  }

  void _startRound() {
    _remainingTime = widget.roundTime;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _nextPlayer();
        }
      });
    });
  }

  void _nextPlayer() {
    setState(() {
      _currentPlayer = (_currentPlayer + 1) % widget.numberOfPlayers;
      _startRound();
    });
  }

  Future<void> _onCardTapped(MemoryCard card) async {
    await _memoryGame.selectCard(card);
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.gridSize} x ${widget.gridSize} Game Board - Player ${_currentPlayer + 1}'),
      ),
      body: Column(
        children: [
          Text('Remaining Time: $_remainingTime'),
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
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: cardSize,
                        height: cardSize,
                        transform: card.isMatched ? Matrix4.identity() : Matrix4.identity()..scale(0.9),
                        decoration: BoxDecoration(
                          color: card.isFaceUp || card.isMatched
                              ? card.isMatched
                              ? Colors.green
                              : Colors.blueAccent
                              : Colors.grey,
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
    );
  }
}
