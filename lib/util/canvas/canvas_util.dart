import 'dart:math';

class CanvasUtils {
  double calculateDistance(int x, int y, int x2, int y2) {
    return pow(pow(x - x2, 2) + pow(y - y2, 2), 1 / 2).toDouble();
  }

  static String formatMoney(double money) {
    if (money < 2000) return money.floor().toString();
    if (money < 2000000)
      return '${(money / 1000).toStringAsPrecision(3)}k';
    else
      return '${(money / 1000).toStringAsPrecision(6)}M';
  }
}
