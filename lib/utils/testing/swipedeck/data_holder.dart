import 'package:flutter/foundation.dart';

const defaultSpread = 0.0872665;

class TransformData extends ChangeNotifier {
  bool _leftDrag = false;
  double _tDelta = 0;
  double spreadRadians = defaultSpread; // 5 Degrees

  TransformData({required this.spreadRadians});

  get isLeftDrag => _leftDrag;
  get transformDelta => _tDelta;

  setTransformDelta(double newDelta) {
    _tDelta = newDelta;
    notifyListeners();
  }

  setLeftDrag(bool isLeftDrag) {
    _leftDrag = isLeftDrag;
  }
}
