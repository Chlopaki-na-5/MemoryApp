import 'package:flutter/material.dart';
import '../models/memory_card.dart';
import '../game/memory_game.dart';

class GameBoard extends StatefulWidget {
  final int gridSize;

  const GameBoard({super.key, required this.gridSize});

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late MemoryGame _memoryGame;

  @override
  void initState() {
    super.initState();
    _memoryGame = MemoryGame(gridSize: widget.gridSize);
  }

  void _onCardTapped(MemoryCard card) async {
    setState(() {});
    await _memoryGame.selectCard(card);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.gridSize} x ${widget.gridSize} Game Board'),
      ),
      body: LayoutBuilder(
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
    );
  }
}
