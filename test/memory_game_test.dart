import 'package:flutter_test/flutter_test.dart';
import '../lib/game/memory_game.dart';
import '../lib/models/memory_card.dart';

void main() {
  group('MemoryGame', () {
    test('initializes correctly', () {
      final game = MemoryGame(gridSize: 4);

      expect(game.cards.length, 16);
      expect(game.firstSelectedCard, isNull);
      expect(game.secondSelectedCard, isNull);
      expect(game.isProcessing, isFalse);
      expect(game.isPairFound, isFalse);
      expect(game.isGameOver, isFalse);
    });

    test('selecting cards works correctly', () async {
      final game = MemoryGame(gridSize: 4);

      final firstCard = game.cards[0];
      final secondCard = game.cards.firstWhere((card) => card.id == firstCard.id && card != firstCard);

      await game.selectCard(firstCard);
      expect(firstCard.isFaceUp, isTrue);
      expect(game.firstSelectedCard, firstCard);

      await game.selectCard(secondCard);
      expect(secondCard.isFaceUp, isTrue);
      expect(firstCard.isMatched, isTrue);
      expect(secondCard.isMatched, isTrue);
      expect(game.isPairFound, isTrue);
    });

    test('reset game works correctly', () {
      final game = MemoryGame(gridSize: 4);

      game.resetGame();

      expect(game.cards.length, 16);
      expect(game.firstSelectedCard, isNull);
      expect(game.secondSelectedCard, isNull);
      expect(game.isProcessing, isFalse);
      expect(game.isPairFound, isFalse);
      expect(game.isGameOver, isFalse);
    });

    test('game over detection works correctly', () async {
      final game = MemoryGame(gridSize: 2); // smaller grid for testing

      for (var card in game.cards) {
        await game.selectCard(card);
        await game.selectCard(game.cards.firstWhere((c) => c.id == card.id && c != card));
      }

      expect(game.isGameOver, isTrue);
    });
  });
}
