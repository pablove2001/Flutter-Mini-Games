import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TicTacToeProvider with ChangeNotifier {
  bool _isNoughts = true;
  int _numClick = 0;
  int _winner = 0; // 0:None, 1:O, 2:X, 3:Tie
  List<int> _map = [for (var i = 0; i < 9; i++) 0];

  bool get getIsNoughts => _isNoughts;

  int get getWinner => _winner;

  void setClick(BuildContext context, int numId) {
    if (_map[numId] == 0 && _winner == 0) {
      _numClick++;
      _map[numId] = _isNoughts ? 1 : 2;

      if (kDebugMode) {
        print('click $_numClick = ${_isNoughts ? 'O' : 'X'}');
      }

      _isNoughts = !_isNoughts;

      if (_isWinner()) _winner = !_isNoughts ? 1 : 2;

      if (_numClick == 9 && _winner == 0) _winner = 3;

      if (_winner != 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(_winner != 3 ? 'Winner' : 'Tie'),
              content: Text(_winner != 3
                  ? 'The winner is: ${!_isNoughts ? 'O' : 'X'}'
                  : 'The game ended in a tie'),
              actions: [
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Play Again'),
                  onPressed: () {
                    setRestart();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

      notifyListeners();
    }
  }

  List<int> get getMap => _map;

  void setRestart() {
    _map = [for (var i = 0; i < 9; i++) 0];
    _numClick = 0;
    _winner = 0;
    notifyListeners();
  }

  bool _isWinner() {
    for (int i = 0; i < 3; i++) {
      if (_map[i * 3] != 0 &&
          _map[i * 3] == _map[(i * 3) + 1] &&
          _map[(i * 3) + 1] == _map[(i * 3) + 2]) {
        return true;
      }
      if (_map[i] != 0 &&
          _map[i] == _map[i + 3] &&
          _map[i + 3] == _map[i + 6]) {
        return true;
      }
    }

    if (_map[0] != 0 && _map[0] == _map[4] && _map[4] == _map[8]) return true;
    if (_map[2] != 0 && _map[2] == _map[4] && _map[4] == _map[6]) return true;

    return false;
  }
}
