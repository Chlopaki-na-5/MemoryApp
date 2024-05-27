import 'dart:async';
import '../models/memory_card.dart';

class MemoryGame {
  final int gridSize;
  final List<MemoryCard> cards = [];
  MemoryCard? firstSelectedCard;
  MemoryCard? secondSelectedCard;
  bool _isWaiting = false;

  MemoryGame({required this.gridSize}) {
    _initializeCards();
  }

  void _initializeCards() {
    int numberOfPairs = (gridSize * gridSize) ~/ 2;

    if (numberOfPairs <= 0) {
      throw ArgumentError('Number of pairs must be greater than zero');
    }

    List<MemoryCard> tempCards = [];
    for (int i = 0; i < numberOfPairs; i++) {
      String id = 'pair_$i';
      String content = 'content_$i';
      tempCards.add(MemoryCard(id: id, content: content));
      tempCards.add(MemoryCard(id: id, content: content));
    }

    tempCards.shuffle();
    cards.addAll(tempCards);
  }

  Future<void> selectCard(MemoryCard card) async {
    if (card.isFaceUp || card.isMatched || _isWaiting) {
      return;
    }

    card.isFaceUp = true;

    if (firstSelectedCard == null) {
      firstSelectedCard = card;
    } else if (secondSelectedCard == null) {
      secondSelectedCard = card;

      if (firstSelectedCard!.id == secondSelectedCard!.id) {
        firstSelectedCard!.isMatched = true;
        secondSelectedCard!.isMatched = true;
        _resetSelectedCards();
      } else {
        _isWaiting = true;
        await Future.delayed(const Duration(milliseconds: 400), () {
          firstSelectedCard!.isFaceUp = false;
          secondSelectedCard!.isFaceUp = false;
          _resetSelectedCards();
          _isWaiting = false;
        });
      }
    }
  }

  void _resetSelectedCards() {
    firstSelectedCard = null;
    secondSelectedCard = null;
  }
}
