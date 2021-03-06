import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:community_application/Globals/Values.dart';
import 'package:community_application/Models/Event.dart';
import 'package:community_application/Models/DateTimeObject.dart';
import 'package:community_application/Components/EventWidget.dart';
import 'package:community_application/Utils/DateUtils.dart';
import 'package:community_application/Utils/WidgetUtils.dart';

/// Organize all events of a specific day into a bucket of events for that day
class EventWidgetDateBucket extends StatelessWidget {
  final List<Event> events;
  final DateTime date;

  EventWidgetDateBucket({
    Key key,
    @required this.events,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> eventsInThisBucket = [];
    List<DatetimeObject> sortedByTime = events
      ..sort()
      ..toList();
    for (Event event in sortedByTime) {
      eventsInThisBucket.add(
        new Row(
          children: <Widget>[
            new Expanded(
              child: new EventWidgetContainer(event: event),
            ),
          ],
        ),
      );
    }

    if (eventsInThisBucket.isEmpty) {
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
      child: new Container(
        padding: const EdgeInsets.all(marginpaddingFromScreenFlat),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              width: 40,
              child: new Column(
                children: <Widget>[
                  new Text(weekdays[date.weekday - 1],
                      style: Theme.of(context).textTheme.body2),
                  isAtSameDayAs(date, new DateTime.now())
                      ? returnCircleWidget(
                          new Container(
                            width: 35,
                            height: 35,
                            child: new Center(
                              child: new Text(
                                formatDay(date),
                                style:
                                    Theme.of(context).textTheme.title.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                              ),
                            ),
                          ),
                          color: Theme.of(context).accentColor,
                        )
                      : new Text(
                          formatDay(date),
                          style: Theme.of(context).textTheme.headline,
                        ),
                ],
              ),
            ),
            new Expanded(
              child: new Container(
                padding: const EdgeInsets.only(
                    left: marginpaddingFromScreenFlat,
                    right: marginpaddingFromScreenFlat),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: eventsInThisBucket,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
