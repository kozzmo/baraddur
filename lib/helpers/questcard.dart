import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuestCard extends StatefulWidget {
  final String text;
  final VoidCallback onClose;

  const QuestCard({super.key, required this.text, required this.onClose});

  @override
  State<QuestCard> createState() => _QuestCardState();
}

class _QuestCardState extends State<QuestCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _controller,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(32),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/parchment_texture.jpg'),
                  fit: BoxFit.fill,
                ),
                border: Border.all(color: Colors.brown, width: 3),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.shade300,
                    offset: const Offset(4, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    fontFamily: 'MedievalSharp',
                    fontSize: 16,
                    color: Colors.brown,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 40,
              top: 40,
              child: GestureDetector(
                onTap: widget.onClose,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.brown.shade200.withOpacity(0.8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class QuestCard extends StatelessWidget {
//   final String text;
//   const QuestCard({super.key, required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: const BoxConstraints(
//         maxWidth: 350,
//         minWidth: 200,
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(24),
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//         decoration: BoxDecoration(
//           image: const DecorationImage(
//             image: AssetImage('assets/images/parchment_texture.jpg'),
//             fit: BoxFit.fill,
//           ),
//           border: Border.all(color: Colors.brown, width: 4),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.3),
//               offset: const Offset(4, 4),
//               blurRadius: 8,
//             ),
//           ],
//         ),
//         child: Text(
//           textAlign: TextAlign.justify,
//           text,
//           style: const TextStyle(
//             fontFamily: 'MedievalSharp',
//             fontSize: 16,
//             color: Colors.brown,
//             height: 1.4,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// // import 'package:baraddur/mytiledgame.dart';
// // import 'package:flame/components.dart';
// // import 'package:flame/text.dart';
// // import 'package:flutter/material.dart';
// //
// // class ScrollBox extends PositionComponent with HasGameRef<MyTiledGame> {
// //   final String text;
// //   late Sprite _backgroundSprite;
// //   late TextPaint _textPaint;
// //
// //   ScrollBox({
// //     required this.text,
// //     Vector2? position,
// //     Vector2? size,
// //   }) : super(
// //     position: position ?? Vector2.zero(),
// //     size: size ?? Vector2(120, 120),
// //   );
// //
// //   @override
// //   Future<void> onLoad() async {
// //     super.onLoad();
// //
// //     final image = await gameRef.images.load('parchment_texture.jpg');
// //     _backgroundSprite = Sprite(image);
// //
// //     _textPaint = TextPaint(
// //       style: const TextStyle(
// //         fontSize: 12,
// //         color: Colors.brown,
// //         fontFamily: 'MedievalSharp',
// //       ),
// //     );
// //   }
// //
// //   @override
// //   void render(Canvas canvas) {
// //     super.render(canvas);
// //
// //     // Dessine le fond avec l'image
// //     _backgroundSprite.render(
// //       canvas,
// //       size: size,
// //     );
// //
// //     // Bordure
// //     final borderPaint = Paint()
// //       ..color = Colors.brown
// //       ..style = PaintingStyle.stroke
// //       ..strokeWidth = 3;
// //
// //     final rect = size.toRect();
// //     canvas.drawRRect(
// //       RRect.fromRectAndRadius(rect, const Radius.circular(12)),
// //       borderPaint,
// //     );
// //
// //     // Ombre (optionnelle)
// //     canvas.drawShadow(
// //       Path()..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(12))),
// //       Colors.brown.shade300,
// //       3,
// //       false,
// //     );
// //
// //     // Texte (à améliorer : gestion du retour à la ligne)
// //     _textPaint.render(
// //       canvas,
// //       text,
// //       Vector2(16, 16),
// //     );
// //   }
// // }
