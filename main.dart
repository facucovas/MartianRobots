import 'const.dart';
import 'entities/planet.dart';
import 'entities/position.dart';
import 'entities/robot.dart';

late Planet _planet;

void main() {
  const initialInstructions = '''5 3
1 1 E
RFRFRFRF
3 2 N
FRRFLLFFRRFLL
0 3 W
LLFFFLFLFL''';

  _startProgram(initialInstructions);
}

_startProgram(String initialInstructions) {
  List<String> _positions = [];
  List<String> _instructions = [];

  var _parsedInput = initialInstructions.split("\n");
  var _planetBounds = _parsedInput.first.split(' ');
  var _positionsAndInstructions = _parsedInput.sublist(1);

  _createPlanet(_planetBounds);

  for (int i = 0; i < _positionsAndInstructions.length; i++)
    i % 2 == 0
        ? _positions.add(_positionsAndInstructions[i])
        : _instructions.add(_positionsAndInstructions[i]);

  for (int i = 0; i < _positions.length; i++) {
    Robot _robot = _createRobot(_positions[i]);
    _robotInteraction(_robot, _instructions[i]);
  }
}

_createPlanet(List<String> bounds) {
  _planet = Planet(
    bounds: Position(
      x: int.parse(bounds[0]),
      y: int.parse(bounds[1]),
    ),
  );
}

_createRobot(String position) {
  var _initialPosition = position.split(' ');

  return Robot(
    position: Position(
      x: int.parse(_initialPosition[0]),
      y: int.parse(
        _initialPosition[1],
      ),
    ),
    direction: _initialPosition[2],
  );
}

_robotInteraction(Robot robot, String instructions) {
  if (instructions.length >= 100)
    throw 'Instruction string must be less than 100 characters';

  if (!regExpInstructions.hasMatch(instructions))
    throw 'Instructions can only include a combination of L, R and F';

  var _robotInstruction = instructions.split('');

  _robotInstruction.forEach(
    (instruction) {
      if (instruction == 'L') robot.turnLeft();
      if (instruction == "R") robot.turnRight();
      if (instruction == "F") _moveForward(robot);
    },
  );

  print(robot);
}

_moveForward(Robot robot) {
  if (_planet.haveScents(robot.actualLocation())) return;

  Position _nextPosition = _calculateNextPosition(
    robot.position,
    robot.direction,
  );

  if (_planet.validateBounds(_nextPosition)) {
    _planet.addNewScent(robot.actualLocation());
    robot.imLost();
  }

  robot.setNewPosition(_nextPosition);
}

Position _calculateNextPosition(Position robotPosition, String direction) {
  switch (direction) {
    case 'N':
      return Position(x: robotPosition.x, y: robotPosition.y + 1);
    case 'E':
      return Position(x: robotPosition.x + 1, y: robotPosition.y);
    case 'S':
      return Position(x: robotPosition.x, y: robotPosition.y - 1);
    case 'W':
      return Position(x: robotPosition.x - 1, y: robotPosition.y);
    default:
      return Position(x: robotPosition.x, y: robotPosition.y);
  }
}
