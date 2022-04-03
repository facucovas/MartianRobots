import 'position.dart';

class Planet {
  Position bounds;
  List<String> scents = [];

  Planet({
    required this.bounds,
  }) {
    if (bounds.x > 50 || bounds.y > 50) throw 'bounds must be less than 50';
    bounds = bounds;
  }

  haveScents(String location) {
    return scents.contains(location);
  }

  validateBounds(Position position) {
    if (position.x > bounds.x || position.y > bounds.y) return true;
    if (position.x < 0 || position.y < 0) return true;

    return false;
  }

  addNewScent(String location) {
    scents.add(location);
  }
}
