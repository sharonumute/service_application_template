import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:community_application/Utils/DateUtils.dart';
import 'package:community_application/Utils/WidgetUtils.dart';
import 'package:sticky_headers/sticky_headers.dart';

/// Organize all events into buckets for each month-year pair
class WidgetMonthYearBucket extends StatelessWidget {
  final List<Widget> items;
  final DateTime date;

  WidgetMonthYearBucket({
    Key key,
    @required this.items,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> itemsInThisBucket = [];

    for (Widget item in items) {
      itemsInThisBucket.add(
        item,
      );
    }

    if (itemsInThisBucket.isEmpty) {
      return nullWidget();
    }

    return new Card(
      color: Colors.transparent,
      margin: const EdgeInsets.all(0),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: StickyHeader(
        header: Center(
          child: Chip(
            backgroundColor: Theme.of(context).backgroundColor,
            label: Text(formatMonth(date),
                style: Theme.of(context).textTheme.body2),
          ),
        ),
        content: new Column(
          children: itemsInThisBucket,
        ),
      ),
    );
  }
}
