import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/int_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_stack_view/image_stac_view.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';

import '../../../../core/components/constant/handle_time.dart';
import '../../../../core/components/widgets/money_minder/category_icon.dart';

class BillDetailScreen extends StatefulWidget {
  const BillDetailScreen({super.key});

  @override
  State<BillDetailScreen> createState() => _BillDetailScreenState();
}

class _BillDetailScreenState extends State<BillDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: context.titleLarge.color),
        ),
        centerTitle: true,
        title: Text(
          S.of(context).splitBill,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 10.0),
          _headerBillView(context),
          HeaderTextCustom(
            headerText: S.of(context).splitDetail,
            textStyle:
                context.titleMedium.copyWith(fontWeight: FontWeight.w600),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            widget: InkWell(onTap: () {}, child: const Icon(Icons.more_horiz)),
          )
        ].expand((element) => [element, const SizedBox(height: 10.0)]).toList(),
      ),
    );
  }

  Container _headerBillView(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.2),
            blurRadius: 10.0,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CategoryIcon(
                color: Colors.green,
                icon: '🐼',
                radius: 40.0,
                iconSize: 16.0,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'This is test',
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${getYmdFormat(Constant.timeNow)} | ${getjmFormat(Constant.timeNow)}',
                      style: context.titleSmall.copyWith(
                        color: Theme.of(context).hintColor,
                        fontSize: 11.0,
                      ),
                    )
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.share))
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text(
                S.of(context).totalBills,
                style:
                    context.titleMedium.copyWith(fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Text(
                  1231000.price,
                  textAlign: TextAlign.end,
                  style: context.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).people,
                style: context.titleSmall.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
              ImageStackView(
                images: const [
                  'https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg',
                  'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
                  'https://imgv3.fotor.com/images/blog-richtext-image/part-blurry-image.jpg',
                  'https://imgv3.fotor.com/images/blog-cover-image/Image-Upscaler-2.jpg',
                  'https://imgv3.fotor.com/images/blog-richtext-image/part-blurry-image.jpg',
                  'https://imgv3.fotor.com/images/blog-cover-image/Image-Upscaler-2.jpg',
                  'https://imgv3.fotor.com/images/blog-richtext-image/part-blurry-image.jpg',
                  'https://imgv3.fotor.com/images/blog-cover-image/Image-Upscaler-2.jpg'
                ],
                isAssetImage: false,
                itemsDisplay: 6,
                actionColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            ],
          ),
        ].expand((element) => [element, const SizedBox(height: 5.0)]).toList()
          ..removeLast(),
      ),
    );
  }
}
