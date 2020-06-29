import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/widgets/progress_item.dart';
import 'package:flutter/material.dart';

class ProgressWidget extends StatefulWidget {
  final List<String> status;

  const ProgressWidget({Key key, this.status}) : super(key: key);
  @override
  _ProgressWidgetState createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ProgressItem(
            color: widget.status.contains("recieved")
                ? Color(0xFF13F57D)
                : Colors.grey,
            name: "Recieved",
            icon: EvaIcons.checkmarkSquareOutline,
            keyword: "recieved",
            isDisabled: widget.status.contains("recieved") ? false : true,
          ),
          ProgressItem(
            color: widget.status.contains("preparing")
                ? Color(0xFF9213F5)
                : Colors.grey,
            name: "Preparing",
            icon: EvaIcons.cubeOutline,
            keyword: "preparing",
            isDisabled: widget.status.contains("preparing") ? false : true,
          ),
          ProgressItem(
            color: widget.status.contains("dispatched")
                ? Color(0xFF13F5C2)
                : Colors.grey,
            name: "Dispatched",
            icon: EvaIcons.carOutline,
            keyword: "dispatched",
            isDisabled: widget.status.contains("dispatched") ? false : true,
          ),
        ],
      ),
    );
  }
}
