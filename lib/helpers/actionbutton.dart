import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final VoidCallback onPressed;

  const ActionButton({super.key, required this.onPressed});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  double _scale = 1.0 ;

  void _onTapDown(_) => setState(() => _scale = 0.95);
  void _onTapUp(_) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            shadowColor: Colors.black,
            animationDuration: Duration(seconds: 2),
            shape: CircleBorder(),
            //padding: EdgeInsets.all(20)
          ),
          onPressed: widget.onPressed,
          child: ClipOval(
            child: Image.asset(
              width: 80,
              height: 80,
              'assets/images/logoBaraddur.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

}
