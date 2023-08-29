import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/widget_exetions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/skeleton_custom.dart';

import '../product/views/product_horizontal_card.dart';

typedef CollectionFetch<T> = Future<List<T>> Function();

class ItemHorizontalField<T, R extends Widget> extends StatefulWidget {
  final CollectionFetch<T>? fetchCollection;

  final List<T> initData;

  final bool isUpdateWhenMounted;

  final Function()? actionPress;

  final R Function(T data) itemBuilder;

  final double spacingItem;

  ///[header type]
  final String? headerTitle;

  final String? subTitle;

  final String? behindImage;

  final double imageHeight;

  final double spacingFromHeader;

  final String? actionTitle;

  final TextStyle? headerStyle;

  final TextStyle? subTitleStyle;

  final TextStyle? actionStyle;

  final Widget? leading;

  final bool loadingCard;

  const ItemHorizontalField({
    Key? key,
    this.leading,
    this.subTitle,
    this.actionTitle,
    this.actionPress,
    this.headerStyle,
    this.behindImage,
    this.actionStyle,
    this.headerTitle,
    this.subTitleStyle,
    this.initData = const [],
    this.loadingCard = false,
    this.spacingItem = 10.0,
    this.imageHeight = 220.0,
    this.spacingFromHeader = 10.0,
    this.isUpdateWhenMounted = true,
    this.fetchCollection,
    required this.itemBuilder,
  })  : assert(
          isUpdateWhenMounted
              ? fetchCollection != null
              : fetchCollection == null,
        ),
        super(key: key);

  @override
  State<ItemHorizontalField<T, R>> createState() =>
      _ItemHorizontalFieldState<T, R>();
}

class _ItemHorizontalFieldState<T, R extends Widget>
    extends State<ItemHorizontalField<T, R>> {
  final _typeOfBody = [ProductHorizontalCard].contains(R);

  ///[true] is column [false] is row

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onFetchData();
    });
    super.initState();
  }

  void _onFetchData() async {
    if (!widget.isUpdateWhenMounted) {
      _listItem.addAll(widget.initData);
      setState(() {});
      return;
    }
    setState(() {
      _loading = true;
    });
    _listItem = await widget.fetchCollection!.call();
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
  }

  @override
  void didUpdateWidget(ItemHorizontalField<T, R> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // _onFetchData();
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
              onTap: widget.actionPress,
              child: Text(widget.actionTitle ?? '', style: _actionStyle),
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        Stack(
          children: [
            ///[image behind only support for network image]
            if (widget.behindImage?.isNotEmpty ?? false)
              ImageCustom(
                imageUrl: widget.behindImage!,
                isNetworkImage: true,
                width: double.infinity,
                height: widget.imageHeight,
              ),
            if (_loading) _loadingRender() else _renderBody(),
          ],
        )
      ],
    );
  }

  Widget _displayItem() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            SizedBox(width: widget.spacingFromHeader),
            ..._listItem
                .map(
                  (e) => widget.itemBuilder(e),
                )
                .expand((e) => [e, SizedBox(width: widget.spacingItem)]),
          ],
        ),
      );

  Widget _renderBody() {
    if (_typeOfBody) {
      return Column(
        children: [
          ..._listItem
              .map(
                (e) => widget.itemBuilder(e),
              )
              .expand((e) => [e, SizedBox(height: widget.spacingItem)]),
        ],
      );
    }
    return _displayItem();
  }

  Widget _loadingRender() {
    if (_typeOfBody) {
      return Column(
        children: [
          for (int i = 0; i < 4; i++) _loadingItem(),
        ].expand((e) => [e, SizedBox(width: widget.spacingItem)]).toList(),
      );
    }
    return _loadingBuild();
  }

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

  Container _loadingItem() {
    return Container(
      width: _typeOfBody ? double.infinity : 160.0,
      height: _typeOfBody ? 100.0 : null,
      padding: const EdgeInsets.all(10.0),
      decoration: widget.loadingCard
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.2),
                  blurRadius: 5.0,
                )
              ],
            )
          : null,
      child: _typeOfBody
          ? Row(
              children: [
                SkeletonContainer.circular(
                  width: 100.0,
                  borderRadius: BorderRadius.circular(5.0),
                  height: double.infinity,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: SkeletonContainer.circular(
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(5.0),
                    height: double.infinity,
                  ),
                )
              ],
            )
          : Column(
              children: [
                SizedBox(width: widget.spacingFromHeader),
                ...<double>[140.0, 20.0, 20.0]
                    .map(
                      (e) => SkeletonContainer.circular(
                        width: double.infinity,
                        borderRadius: BorderRadius.circular(5.0),
                        height: e,
                      ),
                    )
                    .expand((e) => [e, const SizedBox(height: 10.0)])
                    .toList()
                  ..removeLast(),
              ],
            ),
    );
  }
}
