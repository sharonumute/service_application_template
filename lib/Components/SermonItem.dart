import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/Components/CustomText.dart';
import 'package:service_application/Components/PersonaCoin.dart';
import 'package:service_application/Globals/Values.dart';
import 'package:service_application/Pages/ComponentPages/SermonItemPage.dart';
import 'package:service_application/Utils/CommonUtils.dart';
import 'package:service_application/Utils/DataUtils.dart';
import 'package:service_application/Utils/DateUtils.dart';
import 'package:service_application/Store/State.dart';
import 'package:service_application/Store/Actions.dart';
import 'package:service_application/Strings/ErrorMessages.dart';

class SermonItemContainer extends StatelessWidget {
  final Sermon sermon;
  final int numberOfLinesOnMinimized;

  SermonItemContainer({Key key, this.sermon, this.numberOfLinesOnMinimized})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store, sermon);
      },
      builder: (context, vm) {
        return SermonItem(
          title: sermon.title,
          date: sermon.date,
          preacher: sermon.author,
          sermon: sermon.content,
          numberOfLinesOnMinimized: numberOfLinesOnMinimized,
          onSermonSelected: vm.onSermonSelected,
        );
      },
    );
  }
}

class SermonItem extends StatelessWidget {
  SermonItem(
      {Key key,
      this.title,
      this.date,
      this.preacher,
      this.sermon,
      this.numberOfLinesOnMinimized = 2,
      this.onSermonSelected})
      : super(key: key);

  final String title;
  final DateTime date;
  final Person preacher;
  final String sermon;
  final int numberOfLinesOnMinimized;
  final Function onSermonSelected;

  @override
  Widget build(BuildContext context) {
    void _openSermon() {
      Navigator.of(context).push(
        new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return SermonItemPage(
              title: title,
              date: date,
              preacher: preacher,
              sermon: sermon,
            );
          },
        ),
      );
    }

    void _onSermonSelected() {
      _openSermon();

      try {
        onSermonSelected();
      } on NoSuchMethodError {
        print(STORELESS_COMPONENT_WITH_UNDEFINED_VIEWMODEL_FUNCTION);
      }
    }

    return new Card(
      margin: const EdgeInsets.only(
          left: marginpaddingFromScreenHover,
          right: marginpaddingFromScreenHover,
          top: 5.0,
          bottom: 5.0),
      elevation: cardResting,
      clipBehavior: Clip.hardEdge,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(boxborderRadius),
      ),
      child: InkWell(
        onTap: _onSermonSelected,
        child: Container(
          padding: const EdgeInsets.all(paddingFromWalls),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                title,
                style: Theme.of(context).textTheme.headline,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              new Padding(
                padding: EdgeInsets.all(dividerPadding / 2),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new PersonaCoin(person: preacher, diameter: 20.0),
                      new Text(
                        preacher.name,
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ],
                  ),
                  new Text(
                    "${presentationFullDayFormat(date)}",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              new Padding(
                padding: EdgeInsets.all(dividerPadding),
              ),
              // sermon
              ifEmptyOrNull(sermon)
                  ? null
                  : new CustomText(
                      text: sermon,
                      numberOfMinimalLines: numberOfLinesOnMinimized ?? 2,
                      expanded: false,
                      textStyle: Theme.of(context).textTheme.body2,
                    ),
            ].where(ifObjectIsNotNull).toList(),
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final Function onSermonSelected;

  _ViewModel({
    @required this.onSermonSelected,
  });

  factory _ViewModel.from(Store<AppState> store, Sermon sermon) {
    return _ViewModel(
      onSermonSelected: () => store.dispatch(SermonSelectedAction(sermon)),
    );
  }
}
