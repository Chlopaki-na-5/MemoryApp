import 'dart:async';
import '../models/memory_card.dart';

class MemoryGame {
  final int gridSize;
  final List<MemoryCard> cards = [];
  MemoryCard? firstSelectedCard;
  MemoryCard? secondSelectedCard;
  bool isProcessing = false;

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
    if (isProcessing || card.isFaceUp || card.isMatched) {
      return;
    }

    card.isFaceUp = true;

    if (firstSelectedCard == null) {
      firstSelectedCard = card;
    } else if (secondSelectedCard == null) {
      secondSelectedCard = card;
      isProcessing = true;

      if (firstSelectedCard!.content == secondSelectedCard!.content) {
        firstSelectedCard!.isMatched = true;
        secondSelectedCard!.isMatched = true;
        _resetSelectedCards();
      } else {
        await Future.delayed(const Duration(seconds: 3));
        firstSelectedCard!.isFaceUp = false;
        secondSelectedCard!.isFaceUp = false;
        _resetSelectedCards();
      }

      isProcessing = false;
    }
  }

  void _resetSelectedCards() {
    firstSelectedCard = null;
    secondSelectedCard = null;
  }
}
