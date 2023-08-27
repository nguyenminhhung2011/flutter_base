import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:super_banners/super_banners.dart';

class CollectionCard extends StatelessWidget {
  final Function()? onPress;

  final String image;

  final String header;

  final TextStyle? headerStyle;

  final double? imageBorder;

  final List<String> subCategories;

  ///[banner style] Set up banner style here
  final Widget? banner;

  final Color? bannerColor;

  final double? elevation;

  final CornerBannerPosition? cornerBannerPosition;

  const CollectionCard({
    super.key,
    this.banner,
    this.elevation,
    this.onPress,
    this.bannerColor,
    this.imageBorder,
    this.headerStyle,
    this.cornerBannerPosition,
    this.subCategories = const <String>[],
    required this.image,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        width: 140.0,
        child: _builder(context),
      ),
    );
  }

  Stack _builder(BuildContext context) {
    Color bColor = bannerColor ?? Theme.of(context).primaryColor;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(imageBorder ?? 5.0),
              child: ImageCustom(
                width: 140.0,
                height: 140.0,
                imageUrl: image,
                isNetworkImage: true,
                isSkelton: true,
              ),
            ),
            Text(
              header,
              maxLines: 2,
              style: headerStyle ??
                  context.titleSmall.copyWith(
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
            if (subCategories.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...subCategories
                        .map(
                          (e) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 5.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(width: 1, color: bColor),
                            ),
                            child: Text(
                              e,
                              style: context.titleSmall.copyWith(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w500,
                                color: bColor,
                              ),
                            ),
                          ),
                        )
                        .expand((e) => [e, const SizedBox(width: 5.0)])
                  ],
                ),
              ),
          ].expand((e) => [e, const SizedBox(height: 10.0)]).toList()
            ..removeLast(),
        ),
        if (banner != null)
          CornerBanner(
            bannerPosition:
                cornerBannerPosition ?? CornerBannerPosition.topLeft,
            bannerColor: bColor,
            shadowColor: Colors.black.withOpacity(0.8),
            elevation: elevation ?? 5.0,
            child: banner!,
          ),
      ],
    );
  }
}
