import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prank_app/utils/theme.dart';

class AnimatedFlipCounter extends StatelessWidget {
  final int value;
  final Duration duration;
  final double size;
  final Color color;
  final VoidCallback celebrate;

  const AnimatedFlipCounter({
    Key key,
    @required this.value,
    @required this.duration,
    this.size = 72,
    this.color = Colors.black, this.celebrate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> digits = value == 0 ? [0] : [];

    int v = value;
    if (v < 0) {
      v *= -1;
    }
    while (v > 0) {
      digits.add(v);
      v = v ~/ 10;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "+",
          style: MyTextStyles.bigTitleBold.apply(fontSizeFactor: 1.5, color: value == 0 ? Colors.white : Colors.black),
          textAlign: TextAlign.center,
        ),
        Row(
          children: List.generate(digits.length, (int i) {
            return _SingleDigitFlipCounter(
              key: ValueKey(digits.length - i),
              value: digits[digits.length - i - 1].toDouble(),
              duration: duration,
              height: size,
              width: size / 1.8,
              color: color,
              celebrate: celebrate,
            );
          }),
        ),
      ],
    );
  }
}

class _SingleDigitFlipCounter extends StatelessWidget {
  final double value;
  final Duration duration;
  final double height;
  final double width;
  final Color color;
  final VoidCallback celebrate;

  const _SingleDigitFlipCounter({
    Key key,
    @required this.value,
    @required this.duration,
    @required this.height,
    @required this.width,
    @required this.color, this.celebrate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: value, end: value),
      duration: duration,
      onEnd: this.celebrate,
      builder: (context, value, child) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        return SizedBox(
          height: height,
          width: width,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildSingleDigit(
                digit: whole % 10,
                offset: height * decimal,
                opacity: 1 - decimal,
              ),
              _buildSingleDigit(
                digit: (whole + 1) % 10,
                offset: height * decimal - height,
                opacity: decimal,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSingleDigit({int digit, double offset, double opacity}) {
    return Positioned(
      child: SizedBox(
        width: width,
        child: Opacity(
          opacity: opacity,
          child: Row(
            children: <Widget>[
              Text(
                "$digit",
                style: MyTextStyles.bigTitleBold.apply(fontSizeFactor: 1.5, color: value == 0 ? Colors.white : Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottom: offset,
    );
  }
}