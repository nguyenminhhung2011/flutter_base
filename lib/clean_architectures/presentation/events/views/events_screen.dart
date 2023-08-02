import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/hero_tag.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';

import '../../../../core/components/widgets/banner/banner_slider.dart';
import '../../../../core/components/widgets/money_minder/event_view_item.dart';
import '../../../../core/components/widgets/money_minder/nearest_transaction.dart';

class EventsSCreen extends StatefulWidget {
  const EventsSCreen({super.key});

  @override
  State<EventsSCreen> createState() => _EventsSCreenState();
}

class _EventsSCreenState extends State<EventsSCreen> {
  final bannerImages = <String>[
    'https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg',
    'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
    'https://imgv3.fotor.com/images/blog-richtext-image/part-blurry-image.jpg',
    'https://imgv3.fotor.com/images/blog-cover-image/Image-Upscaler-2.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: Hero(
        tag: HeroTag.buttonAddEventTag,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 23.0),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        toolbarHeight: 80.0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: context.titleLarge.color),
        ),
        title: Text(
          S.of(context).discoverEvents,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          BannerSliderWidget(
            width: double.infinity,
            dotPosition: MainAxisAlignment.center,
            hPadding: 0.0,
            itemsPerPage: 1,
            radius: 0.0,
            height: 170.0,
            dotColor: Theme.of(context).primaryColor,
            images: bannerImages,
          ),
          _rowHeader(context,
              header: S.of(context).currentEvent,
              actionString: S.of(context).viewAll,
              onActionPress: () {}),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: <Widget>[
                const SizedBox(width: Constant.hPadding),
                ...bannerImages.mapIndexed(
                  (index, e) => EventViewItem(
                    startTime: Constant.timeNow,
                    endTime: Constant.timeNow.add(const Duration(days: 1)),
                    header: 'This is test event $index',
                    price: 1231000,
                    id: index.toString(),
                    url: e,
                  ),
                ),
              ].expand((e) => [e, const SizedBox(width: 10.0)]).toList()
                ..removeAt(0),
            ),
          ),
          const SizedBox(),
          _rowHeader(context,
              header: S.of(context).nearestTransaction,
              actionString: S.of(context).viewAll,
              onActionPress: () {}),
          const SizedBox(height: 10.0),
          const NearestTransactions(),
          const SizedBox(height: 30.0),
        ].expand((e) => [e, const SizedBox(height: 5.0)]).toList(),
      ),
    );
  }

  HeaderTextCustom _rowHeader(
    BuildContext context, {
    required String header,
    required String actionString,
    required Function() onActionPress,
  }) {
    return HeaderTextCustom(
      headerText: header,
      textStyle: context.titleMedium.copyWith(
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      widget: InkWell(
        onTap: onActionPress,
        child: Text(
          actionString,
          style: context.titleSmall.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
