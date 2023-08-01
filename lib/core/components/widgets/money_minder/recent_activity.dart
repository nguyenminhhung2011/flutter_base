  
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/int_extension.dart';

import '../../constant/handle_time.dart';
import 'category_icon.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({
    super.key,
    required this.header,
    required this.timeCreated,
    required this.price,
    required this.icon,
    required this.borderColor,
  });

  final String header;
  final DateTime timeCreated;
  final int price;
  final String icon;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
        children: [
          CategoryIcon(
            color: borderColor,
            icon: icon,
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
                  header,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${getYmdFormat(timeCreated)} | ${getjmFormat(timeCreated)}',
                  style: context.titleSmall.copyWith(
                    color: Theme.of(context).hintColor,
                    fontSize: 11.0,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 5.0),
          Text(
            price.price,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
