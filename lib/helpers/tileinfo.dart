import 'package:flame/extensions.dart';

class TileInfo {
  TileInfo({
    required this.center,
    required this.row,
    required this.col,
  });

  final Offset center;
  final int row;
  final int col;
}