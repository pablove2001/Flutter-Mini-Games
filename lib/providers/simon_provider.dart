import 'dart:math';

import 'package:flutter/material.dart';

class SimonProvider with ChangeNotifier {
  int _points = 0;
  int _record = 0;
  int _level = 0;
  int _status = 0; // 0  start/end, 1 watching, 2 repeating
  int _count = 0; // number of clicks
  List<int> _map = [0, 0, 0, 0];
  List<int> _history = [];

  int get getPoints => _points;
  int get getRecord => _record;
  int get getLevel => _level;
  int get getStatus => _status;
  List<int> get getMap => _map;

  void setStart() {
    setStatus0();
    setStatus1();
  }

  void setStatus0() {
    _points = 0;
    _level = 0;
    _status = 0;
    _count = 0;
    _map = [0, 0, 0, 0];
    _history = [];

    notifyListeners();
  }

  void setClick(numId) {
    if (_status == 2) {
      animationClick(numId);
      setStatus2(numId);

      notifyListeners();
    }
  }

  Future<void> animationClick(numId) async {
    _map[numId] = 1;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 100));
    _map[numId] = 0;
    notifyListeners();
  }

  Future<void> setStatus1() async {
    _status = 1;
    _count = 0;
    _level = _history.length + 1;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 700));

    _history.add(getRandom(4));

    for (int i = 0; i < _history.length; i++) {
      _map[_history[i]] = 1;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 500));
      _map[_history[i]] = 0;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 200));
    }

    _status = 2;
    notifyListeners();
  }

  void setStatus2(int numId) {
    _status = 2;
    notifyListeners();

    if (numId != _history[_count]) {
      if (_points > _record) _record = _points;
      notifyListeners();

      setStatus0();

      return;
    }

    _points += 1;
    _count += 1;

    if (_count == _history.length) {
      setStatus1();
      return;
    }
  }

  int getRandom(ran) {
    return Random().nextInt(ran);
  }
}
