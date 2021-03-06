import 'package:flutter/material.dart';

/// Create a text box that can easly be expanded and minimized
///
/// `text`: The content text
///
/// `numberOf_MinimalLines`: The number of lines shown when minimized
///
/// `expanded`: Boolean that decides if box should be expanded or not
class TextWidget extends StatelessWidget {
  TextWidget(
      {Key key,
      this.text,
      this.numberOfMinimalLines,
      this.expanded,
      this.textStyle})
      : super(key: key);

  final String text;
  final int numberOfMinimalLines;
  final bool expanded;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return expanded
        ? new Text(
            text,
            textAlign: TextAlign.left,
            style: textStyle,
          )
        : new Text(
            text,
            maxLines: numberOfMinimalLines,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: textStyle,
          );
  }
}
