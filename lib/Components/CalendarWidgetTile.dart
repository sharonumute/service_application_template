import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';
import 'package:community_application/Utils/CommonUtils.dart';
import 'package:community_application/Models/Event.dart';

/// Modification of `https://pub.dartlang.org/packages/flutter_calendar#-readme-tab-` to include events
class CalendarTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final TextStyle dayOfWeekStyles;
  final TextStyle dateStyles;
  final Widget child;
  final List<Event> validEventTest;

  CalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyles,
    this.isDayOfWeek: false,
    this.isSelected: false,
    this.validEventTest,
  });

  Widget renderDateOrDayOfWeek(BuildContext context) {
    bool hasEvent =
        this.validEventTest != null && this.validEventTest.isNotEmpty;

    if (isDayOfWeek) {
      return new InkWell(
        child: new Container(
            alignment: Alignment.center,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  dayOfWeek,
                  style: dayOfWeekStyles,
                ),
                hasEvent
                    ? new Padding(
                        padding: EdgeInsets.all(2.0),
                      )
                    : null,
                hasEvent
                    ? new Icon(
                        Icons.brightness_1,
                        color: this.validEventTest[0].color,
                        size: 6.0,
                      )
                    : null,
              ].where(ifObjectIsNotNull).toList(),
            )),
      );
    } else {
      return new InkWell(
        onTap: onDateSelected,
        child: new Container(
            decoration: isSelected
                ? new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
                : new BoxDecoration(),
            alignment: Alignment.center,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  Utils.formatDay(date).toString(),
                  style: isSelected
                      ? new TextStyle(
                          color: Theme.of(context).primaryColor,
                        )
                      : dateStyles,
                  textAlign: TextAlign.center,
                ),
                new Padding(
                  padding: EdgeInsets.all(2.0),
                ),
                hasEvent
                    ? new Icon(
                        Icons.brightness_1,
                        color: this.validEventTest[0].color,
                        size: 6.0,
                      )
                    : new Icon(
                        Icons.brightness_1,
                        color: Colors.transparent,
                        size: 6.0,
                      ),
              ].where(ifObjectIsNotNull).toList(),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return new InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return new Container(
      decoration: new BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: renderDateOrDayOfWeek(context),
    );
  }
}
