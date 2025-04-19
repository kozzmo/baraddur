import 'package:baraddur/helpers/parchmentcard.dart';
import 'package:flutter/material.dart';

class MyTextCard extends StatefulWidget {
  final String text;
  final VoidCallback onClose;

  const MyTextCard({super.key, required this.text, required this.onClose});

  @override
  State<MyTextCard> createState() => _MyTextCardState();
}

class _MyTextCardState extends State<MyTextCard>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return ParchmentCard(
      contentWidget: Text(
        textAlign: TextAlign.justify,
        widget.text,
        style: const TextStyle(
          fontFamily: 'MedievalSharp',
          fontSize: 16,
          // fontWeight: FontWeight.bold,
          color: Colors.brown,
          height: 1.4,
        ),
      ),
      onClose: widget.onClose,
    );
  }
}