class MemoryCard {
  final String id;
  final String imageAssetPath;
  bool isFaceUp;
  bool isMatched;

  MemoryCard({
    required this.id,
    required this.imageAssetPath,
    this.isFaceUp = false,
    this.isMatched = false,
  });
}
