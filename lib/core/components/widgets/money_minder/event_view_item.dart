import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/int_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';

class EventViewItem extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;
  final String url;
  final String id;
  final String header;
  final int price;
  const EventViewItem({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.url,
    required this.id,
    required this.header,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final medText = context.titleMedium.copyWith(
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
      fontSize: 14.0,
    );
    final smallText = context.titleSmall.copyWith(
      fontWeight: FontWeight.w500,
      color: Theme.of(context).hintColor,
      fontSize: 11.0,
    );
    return Container(
      width: context.widthDevice * 0.55,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.15),
            Theme.of(context).primaryColor.withOpacity(0.3),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.2),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(url,
                    width: double.infinity,
                    fit: BoxFit.cover, loadingBuilder: (BuildContext context,
                        Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(),
          Text(header, style: medText),
          Text(
            '${getYmdHmFormat(startTime)} - ${getYmdHmFormat(endTime)}',
            style: smallText,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).price, style: smallText),
                    Text(price.price, style: medText)
                  ],
                ),
              ),
              ButtonCustom(
                onPress: () {},
                radius: 5.0,
                enableWidth: false,
                child: Text(S.of(context).select),
              )
            ],
          ),
        ].expand((e) => [e, const SizedBox(height: 5.0)]).toList()
          ..removeLast(),
      ),
    );
  }
}
