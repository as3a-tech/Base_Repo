import 'package:flutter/material.dart';

class CustomLinearSlider extends StatefulWidget {
  final double min;
  final double max;
  final double value;
  final Color? activeColor;
  final Color? inactiveColor;
  final void Function(double)? onChanged;
  const CustomLinearSlider({
    super.key,
    this.min = 0.0,
    this.max = 1.0,
    required this.value,
    this.activeColor,
    this.inactiveColor,
    this.onChanged,
  });

  @override
  State<CustomLinearSlider> createState() => _CustomLinearSliderState();
}

class _CustomLinearSliderState extends State<CustomLinearSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 5,
        trackShape: _SliderCustomTrackShape(),
        overlayShape: SliderComponentShape.noThumb,
        thumbShape: SliderComponentShape.noThumb,
      ),
      child: Slider(
        min: widget.min,
        max: widget.max,
        value: widget.value,
        activeColor: widget.activeColor,
        inactiveColor: widget.inactiveColor,
        onChanged: widget.onChanged,
      ),
    );
  }
}

class _SliderCustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
