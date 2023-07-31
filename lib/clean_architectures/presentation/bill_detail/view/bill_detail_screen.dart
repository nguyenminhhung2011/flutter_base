import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import '../../../../core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import '../../../../core/components/widgets/money_minder/category_icon.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import '../../../../core/components/widgets/expansion_panel_list/expansion_panel_list.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/int_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_stack_view/image_stac_view.dart';

class TransactionsItemView {
  final String header;
  final int countable;
  final int price;
  final bool type; // discount = false, normal = true
  TransactionsItemView({
    required this.header,
    required this.countable,
    required this.price,
    required this.type,
  });
}

class BillPerson {
  final String id;
  final int price;
  final String url;
  final String name;
  BillPerson({
    required this.id,
    required this.price,
    required this.url,
    required this.name,
  });
}

class BillDetailScreen extends StatefulWidget {
  const BillDetailScreen({super.key});

  @override
  State<BillDetailScreen> createState() => _BillDetailScreenState();
}

class _BillDetailScreenState extends State<BillDetailScreen> {
  List<BillPerson> items = [
    ...[0, 1, 2, 3, 4].map(
      (e) => BillPerson(
        id: 'Person $e',
        price: ((e + 1) * 100000),
        url: [
          'https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg',
          'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
          'https://imgv3.fotor.com/images/blog-richtext-image/part-blurry-image.jpg',
          'https://imgv3.fotor.com/images/blog-cover-image/Image-Upscaler-2.jpg',
          'https://imgv3.fotor.com/images/blog-richtext-image/part-blurry-image.jpg',
        ][e],
        name: ['Minh Hung', 'Hoang', 'Thang', 'Tung', 'khai'][e],
      ),
    )
  ];

  Future<List<TransactionsItemView>> load(int index) async {
    await Future.delayed(const Duration(seconds: 3));
    return <TransactionsItemView>[
      for (int i = 0; i < 5; i++)
        TransactionsItemView(
          header: [
            'Matcha Grande',
            'Muffin Badberry, Regular',
            'Tax',
            'Tea',
            'Discounts',
          ][i],
          countable: i + 1,
          price: (i + 1) * 1000,
          type: i % 2 != 0 || i == 0,
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ButtonCustom(
          onPress: () {},
          height: 45.0,
          child: Text(
            S.of(context).sendBill,
            style: context.titleMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
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
          ),
          ExpansionPanelCustom<BillPerson, List<TransactionsItemView>>(
            parentItems: items,
            parentItemBuilder: (_, data, isExpanded) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: _headerItem(data, context),
            ),
            expandPanelColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 5.0),
            bodyItem: (_, items) => _bodyItem(items: items),
            loadBody: load,
          ),
        ].expand((element) => [element, const SizedBox(height: 10.0)]).toList(),
      ),
    );
  }

  Column _bodyItem({required List<TransactionsItemView> items}) {
    final normalItem = <TransactionsItemView>[];
    final discountItem = <TransactionsItemView>[];
    for (var element in items) {
      if (element.type) {
        normalItem.add(element);
      } else {
        discountItem.add(element);
      }
    }

    final itemStyle = context.titleSmall.copyWith(
      fontWeight: FontWeight.w500,
      color: Theme.of(context).hintColor,
      overflow: TextOverflow.ellipsis,
      fontSize: 12.0,
    );

    Widget rowData(TransactionsItemView data) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            Expanded(child: Text(data.header, style: itemStyle)),
            Text('x${data.countable}', style: itemStyle),
            Expanded(
              child: Text(data.price.price,
                  style: itemStyle, textAlign: TextAlign.end),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        ...normalItem.map((e) => rowData(e)),
        if (discountItem.isNotEmpty) ...[
          const Divider(),
          ...discountItem.map((e) => rowData(e))
        ]
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
    );
  }

  Row _headerItem(BillPerson data, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 15.0),
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(data.url),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.name,
                style: context.titleSmall.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.0,
                  color: Theme.of(context).hintColor,
                ),
              ),
              Text(
                data.price.price,
                style:
                    context.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Text(
          S.of(context).billDetail,
          style: context.titleSmall.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 10.0,
            color: Theme.of(context).hintColor,
          ),
        )
      ],
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
