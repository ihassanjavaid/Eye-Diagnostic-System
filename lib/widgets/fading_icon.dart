import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';

class CustomFadingIcon extends StatefulWidget {
  final IconData icon;

  CustomFadingIcon(this.icon);

  @override
  _CustomFadingIconState createState() => _CustomFadingIconState();
}

class _CustomFadingIconState extends State<CustomFadingIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Icon(
        this.widget.icon,
        color: kTealColor,
        size: 60,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}