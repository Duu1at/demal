import 'package:app_ui/colors/app_theme_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
    this.height = 56,
    this.width,
    this.radius = 8,
    this.child,
  });
  final double? height;
  final double? width;
  final double radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.appColors.shimmerBase ?? Colors.grey.shade200,
      highlightColor: context.appColors.shimmerHighlight ?? Colors.grey.shade300,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: context.appColors.shimmerBase,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );
  }
}
