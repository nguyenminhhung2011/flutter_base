import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final Color color;
  final String icon;
  final double radius;
  final double iconSize;
  const CategoryIcon({
    super.key,
    this.radius = 25.0,
    this.iconSize = 10.0,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(width: 1.5, color: color),
      ),
      child: Center(
        child: Text(icon, style: TextStyle(fontSize: iconSize)),
      ),
    );
  }
}
