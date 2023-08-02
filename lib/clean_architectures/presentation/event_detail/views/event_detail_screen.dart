import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/appbar.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';

import '../../../../core/components/constant/handle_time.dart';
import '../../../../core/components/utils/hero_tag.dart';
import '../../../../core/components/widgets/money_minder/recent_activity.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final headingStyle =
        context.titleLarge.copyWith(fontWeight: FontWeight.w600);
    final smallStyle = context.titleSmall.copyWith(
      fontWeight: FontWeight.w500,
      color: Theme.of(context).hintColor,
      fontSize: 12.0,
    );
    final headerStyle =
        context.titleMedium.copyWith(fontWeight: FontWeight.w600);

    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Constant.hPadding),
        child: Hero(
          tag: HeroTag.buttonAddEventTag,
          child: ButtonCustom(
            onPress: () {},
            height: 45.0,
            child: Text(S.of(context).addTransactions),
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              AppBarCustom(
                pinned: true,
                title: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Text(S.of(context).eventDetail, style: headingStyle),
                  const SizedBox(width: 24.0)
                ].expand((e) => [e, const Spacer()]).toList()
                  ..removeLast(),
                backgroundColor: Theme.of(context).primaryColor,
                expandedHeight: context.heightDevice * 0.3,
                widgetExpanded: Stack(
                  children: [
                    Image.network(
                      'https://imgv3.fotor.com/images/blog-cover-image/Image-Upscaler-2.jpg',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).shadowColor.withOpacity(0.3),
                            Theme.of(context).primaryColor.withOpacity(0.1),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    const SizedBox(height: 10.0),
                    _headerField(
                        headingStyle: headingStyle,
                        headerText: 'This is event test'),
                    _smallTextField(
                      smallStyle: smallStyle,
                      text:
                          '${getYmdHmFormat(Constant.timeNow)} - ${getYmdHmFormat(Constant.timeNow)} . Quan Thu DUc , Ho Chi Minh city',
                    ),
                    ...divider,
                    _headerField(
                        headingStyle: headerStyle,
                        headerText: S.of(context).description),
                    _smallTextField(
                      smallStyle: smallStyle,
                      text:
                          'For your business, too, your customers’ wins are your wins. If you’re a small retailer, this is true not just with your in-store customer service, but also your ecommerce website’s overall UX, its check-out flow, your online return options, and your product descriptions.',
                    ),
                    ...divider,
                    _headerField(
                        headingStyle: headerStyle,
                        headerText: S.of(context).transactions),
                    for (int i = 0; i < 5; i++)
                      RecentActivity(
                        header: 'This is transactions test',
                        timeCreated: Constant.timeNow,
                        price: 3021400,
                        icon: '🐼',
                        borderColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: Constant.hPadding,
                          vertical: 5.0,
                        ),
                      ),
                  ].expand((e) => [e, const SizedBox(height: 5.0)]).toList(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> get divider {
    return [
      const SizedBox(),
      const Divider(thickness: 1),
      const SizedBox(),
    ];
  }

  Padding _smallTextField(
      {required TextStyle smallStyle, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constant.hPadding),
      child: Text(text, style: smallStyle),
    );
  }

  HeaderTextCustom _headerField(
      {required TextStyle headingStyle, required String headerText}) {
    return HeaderTextCustom(
      headerText: headerText,
      textStyle: headingStyle,
      padding: const EdgeInsets.symmetric(horizontal: Constant.hPadding),
    );
  }
}
