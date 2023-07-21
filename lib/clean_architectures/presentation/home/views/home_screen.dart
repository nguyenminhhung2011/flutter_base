import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';

import '../../../../core/components/constant/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // style
  @override
  Widget build(BuildContext context) {
    final headerStyle =
        context.titleMedium.copyWith(fontWeight: FontWeight.w500);
    final smallStyle =
        context.titleSmall.copyWith(fontWeight: FontWeight.w500, fontSize: 11);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 230,
                margin: const EdgeInsets.only(
                  left: Constant.hPadding,
                  right: Constant.hPadding / 2,
                ),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                ),
                child: _todayCardField(context, headerStyle, smallStyle),
              ),
              Container(
                width: double.infinity,
                height: 230,
                margin: const EdgeInsets.only(
                  left: Constant.hPadding / 2,
                  right: Constant.hPadding,
                ),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color.fromARGB(255, 252, 180, 73),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).categories, style: headerStyle),
                        const Icon(Icons.arrow_forward_ios_sharp, size: 14.0)
                      ],
                    ),
                  ]
                      .expand(
                          (element) => [element, const SizedBox(height: 10.0)])
                      .toList()
                    ..removeLast(),
                ),
              ),
            ].expand((element) => [Expanded(child: element)]).toList(),
          ),
        ],
      ),
    );
  }

  Column _todayCardField(
    BuildContext context,
    TextStyle headerStyle,
    TextStyle smallStyle,
  ) {
    Widget headText(String title) => Text(
          title,
          style: smallStyle.copyWith(
            color: Colors.white,
            fontSize: 13.0,
          ),
        );
    Widget subText(String title) => Text(
          title,
          style: smallStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).today,
              style: headerStyle.copyWith(
                color: Colors.white,
              ),
            ),
            const Icon(Icons.arrow_forward_ios_sharp,
                size: 14.0, color: Colors.white)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headText(S.of(context).recentSpend),
            const SizedBox(height: 5.0),
            Row(
              children: [
                const CategoryIcon(icon: '🐼', color: Colors.black),
                const SizedBox(width: 3.0),
                Expanded(child: subText('Panda')),
                subText('\$100'),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headText(S.of(context).category),
            const SizedBox(height: 5.0),
            subText('Panda & panda'),
          ],
        )
      ].expand((element) => [element, const Spacer()]).toList()
        ..removeLast(),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final Color color;
  final String icon;
  const CategoryIcon({
    super.key,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.0,
      height: 25.0,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(width: 1.5, color: color),
      ),
      child: Center(
        child: Text(
          icon,
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
