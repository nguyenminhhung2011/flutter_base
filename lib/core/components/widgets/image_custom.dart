import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/skeleton_custom.dart';

class ImageCustom extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? fit;
  final bool isNetworkImage;
  final Color? color;
  final Widget? loadingWidget;
  final bool? isSkelton;
  const ImageCustom({
    super.key,
    this.fit,
    this.width,
    this.color,
    this.radius,
    this.height,
    this.loadingWidget,
    required this.imageUrl,
    required this.isNetworkImage,
    this.isSkelton,
  });

  @override
  Widget build(BuildContext context) {
    if (isNetworkImage) {
      return Image.network(
        imageUrl,
        width: width ?? 50.0,
        height: height ?? 50.0,
        fit: fit ?? BoxFit.cover,
        color: color,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          if (isSkelton ?? false) {
            return SkeletonContainer.circular(
              width: width ?? 50.0,
              height: height ?? 50.0,
              borderRadius: BorderRadius.circular(5.0),
            );
          }
          return loadingWidget ??
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
        },
        errorBuilder: (_, __, ___) => Center(
          child: Text(
            'Image error',
            style: context.titleMedium.copyWith(color: Colors.red),
          ),
        ),
      );
    }
    return Image.asset(
      imageUrl,
      width: width ?? 50.0,
      height: width ?? 50.0,
      fit: BoxFit.cover,
      color: color,
    );
  }
}
