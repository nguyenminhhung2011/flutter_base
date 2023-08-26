import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/widget_exetions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/ecommerce/collection/collection_card.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/skeleton_custom.dart';

typedef CollectionFetch<T> = Future<List<T>> Function();

class CollectionField<T> extends StatefulWidget {
  final CollectionFetch<T> fetchCollection;

  final Function()? actionPress;

  final CollectionCard Function(T data) itemBuilder;

  final double spacingItem;

  ///[header type]
  final String? headerTitle;

  final String? subTitle;

  final String? actionTitle;

  final TextStyle? headerStyle;

  final TextStyle? subTitleStyle;

  final TextStyle? actionStyle;

  final Widget? leading;

  const CollectionField({
    super.key,
    this.leading,
    this.subTitle,
    this.actionTitle,
    this.actionPress,
    this.headerStyle,
    this.actionStyle,
    this.headerTitle,
    this.subTitleStyle,
    this.spacingItem = 10.0,
    required this.fetchCollection,
    required this.itemBuilder,
  });

  @override
  State<CollectionField<T>> createState() => _CollectionFieldState<T>();
}

class _CollectionFieldState<T> extends State<CollectionField<T>> {
  ///[Style]
  TextStyle get _headerStyle =>
      widget.headerStyle ??
      context.titleLarge.copyWith(
          fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor);

  TextStyle get _subStyle =>
      widget.subTitleStyle ??
      context.titleSmall.copyWith(
          fontWeight: FontWeight.w500, color: Theme.of(context).hintColor);

  TextStyle get _actionStyle =>
      widget.subTitleStyle ??
      context.titleSmall.copyWith(
          fontWeight: FontWeight.w500, color: Theme.of(context).hintColor);

  bool _loading = false;

  List<T> _listItem = List<T>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _onFetchData();
  }

  void _onFetchData() async {
    setState(() {
      _loading = true;
    });
    _listItem = await widget.fetchCollection();
    setState(() {
      _loading = false;
    });
  }

  @override
  void didUpdateWidget(CollectionField<T> collectionField) {
    super.didUpdateWidget(collectionField);
    _onFetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          leading: widget.leading,
          title: widget.headerTitle.renderWidgetNull(
            Text(widget.headerTitle ?? '', style: _headerStyle),
          ),
          subtitle: widget.subTitle.renderWidgetNull(
            Text(widget.subTitle ?? '', style: _subStyle),
          ),
          trailing: widget.actionTitle.renderWidgetNull(
            GestureDetector(
              onTap: widget.actionPress ?? () {},
              child: Text(widget.actionTitle ?? '', style: _actionStyle),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        if (_loading) _loadingBuild() else _displayItem(),
      ],
    );
  }

  Widget _displayItem() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            SizedBox(width: widget.spacingItem),
            ..._listItem
                .map(
                  (e) => widget.itemBuilder(e),
                )
                .expand((e) => [e, SizedBox(width: widget.spacingItem)]),
          ],
        ),
      );

  Widget _loadingBuild() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [for (int i = 0; i < 4; i++) _loadingItem()]
            .expand((e) => [e, SizedBox(width: widget.spacingItem)])
            .toList(),
      ),
    );
  }

  SizedBox _loadingItem() {
    return SizedBox(
      width: 140.0,
      child: Column(
        children: [
          SizedBox(width: widget.spacingItem),
          ...<double>[140.0, 20.0, 20.0]
              .map(
                (e) => SkeletonContainer.circular(
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(10.0),
                  height: e,
                ),
              )
              .expand((e) => [e, const SizedBox(height: 10.0)]),
        ],
      ),
    );
  }
}
