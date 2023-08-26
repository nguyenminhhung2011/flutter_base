import 'package:flutter/material.dart';

class AnimatedFavorite extends StatefulWidget {
  final Future Function() onPress;

  ///[animationDuration] default [300ms]
  final int animationDuration;

  final bool isLiked;

  final double? radius;

  const AnimatedFavorite({
    super.key,
    this.radius,
    this.animationDuration = 300,
    required this.onPress,
    required this.isLiked,
  });

  @override
  State<AnimatedFavorite> createState() => _AnimatedFavoriteState();
}

class _AnimatedFavoriteState extends State<AnimatedFavorite>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation _animation;

  double _iconSize = 15.0;
  bool isRun = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
    );
    _animation = Tween(begin: 15.0, end: 20.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut),
    );
    _animation.addListener(_listenAnimation);
    _animationController.addStatusListener(_listenAnimationStatus);
    super.initState();
  }

  void _listenAnimation() {
    setState(() {
      _iconSize = _animation.value;
    });
  }

  void _listenAnimationStatus(AnimationStatus animationStatus) {
    // if (animationStatus == AnimationStatus.completed) {
    //   if (isRun == false) {
    //     _animationController.reverse();
    //   }
    // }
  }

  void _onTap() async {
    if (isRun) {
      return;
    }
    isRun = true;
    if (widget.isLiked) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    await widget.onPress();
    isRun = false;
  }

  @override
  void dispose() {
    _animation.removeListener(_listenAnimation);
    _animationController.removeStatusListener(_listenAnimationStatus);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(7.0),
              topRight: Radius.circular(widget.radius ?? 0.0),
            ),
            gradient: LinearGradient(
              colors: <Color>[
                Theme.of(context).hintColor.withOpacity(0.6),
                Theme.of(context).hintColor.withOpacity(0.7),
              ],
            ),
          ),
          child: widget.isLiked
              ? Icon(Icons.favorite, color: Colors.red, size: _iconSize)
              : Icon(Icons.favorite_outline,
                  size: _iconSize, color: Colors.black),
        ),
      ),
    );
  }
}
