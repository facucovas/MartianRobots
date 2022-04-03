class Position {
  int x;
  int y;

  Position({
    required this.x,
    required this.y,
  });

  @override
  String toString() {
    return '$x $y';
  }
}
