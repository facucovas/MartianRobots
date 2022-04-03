import '../const.dart';
import 'position.dart';

class Robot {
  Position position;
  String direction;
  bool lost;

  Robot({
    required this.position,
    required this.direction,
    this.lost = false,
  });

  @override
  String toString() {
    return '$position $direction ${lost ? 'LOST' : ''}';
  }

  String actualLocation() {
    return '$position $direction';
  }

  setNewPosition(Position newPosition) {
    position = newPosition;
  }

  imLost() {
    this.lost = true;
  }

  turnLeft() {
    int index = cardinalPoints.indexOf(direction);

    if (index + 1 >= cardinalPoints.length)
      index = 0;
    else
      index++;

    direction = cardinalPoints.elementAt(index);
  }

  turnRight() {
    int index = cardinalPoints.indexOf(direction);
    if (index - 1 < 0) index = cardinalPoints.length;

    direction = cardinalPoints.elementAt(index - 1);
  }
}
