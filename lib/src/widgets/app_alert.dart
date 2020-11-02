import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppAlert extends StatefulWidget {
  final bool isCollapsible;
  final String message, priority;
  final Function() onCollapse;
  const AppAlert({
    Key key,
    this.isCollapsible = true,
    this.message,
    this.priority,
    this.onCollapse,
  }) : super(key: key);

  @override
  _AppAlertState createState() => _AppAlertState();
}

class _AppAlertState extends State<AppAlert> {
  bool _isVisible = true;
  final Map<String, dynamic> _priorityColors = {
    "error": {
      "foregroundColor": Color(
        0xFFAB304C,
      ),
      "backgroundColor": Color(
        0xFFFF6A8C,
      ),
    },
    "warning": {
      "foregroundColor": Color(
        0xFFABA930,
      ),
      "backgroundColor": Color(
        0xFFFFFD6A,
      ),
    },
    "success": {
      "foregroundColor": Colors.blue[900],
      "backgroundColor": Colors.blue[50],
    }
  };
  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Container(
            padding: widget.isCollapsible
                ? EdgeInsets.only(
                    left: 15,
                    top: 5,
                    bottom: 5,
                  )
                : EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
            margin: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: _priorityColors[widget.priority]["backgroundColor"],
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.message,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.nunito(
                      color: _priorityColors[widget.priority]
                          ["foregroundColor"],
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                widget.isCollapsible == true
                    ? IconButton(
                        icon: Icon(
                          EvaIcons.closeOutline,
                          color: _priorityColors[widget.priority]
                              ["foregroundColor"],
                        ),
                        onPressed: widget.onCollapse != null
                            ? widget.onCollapse
                            : () {
                                this.setState(
                                  () {
                                    _isVisible = false;
                                  },
                                );
                              },
                      )
                    : Container(),
              ],
            ),
          )
        : Container();
  }
}
