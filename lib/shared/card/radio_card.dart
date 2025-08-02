import 'package:flutter/material.dart';

typedef _CardBuilder =
    Card Function({
      required Clip clipBehavior,
      required Widget child,
    });

class RadioCard<T, TGroup> extends StatelessWidget {
  final T data;

  final TGroup? id;
  final TGroup? groupId;

  final Widget title;
  final Widget? subtitle;

  final void Function(T data) onTap;
  final void Function(T data)? onLongPress;

  final _CardBuilder _cardBuilder;

  const RadioCard({
    super.key,
    required this.data,
    required this.id,
    required this.groupId,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.onLongPress,
  }) : _cardBuilder = Card.new;

  const RadioCard.filled({
    super.key,
    required this.data,
    required this.id,
    required this.groupId,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.onLongPress,
  }) : _cardBuilder = Card.filled;

  const RadioCard.outlined({
    super.key,
    required this.data,
    required this.id,
    required this.groupId,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.onLongPress,
  }) : _cardBuilder = Card.outlined;

  @override
  Widget build(BuildContext context) {
    return _cardBuilder(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: title,
        subtitle: subtitle,
        leading: IgnorePointer(
          child: Radio(
            value: id,
            groupValue: groupId,
            onChanged: (value) {},
          ),
        ),
        onTap: () => onTap(data),
        onLongPress: () => onLongPress?.call(data),
      ),
    );
  }
}
