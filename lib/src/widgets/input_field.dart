import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatefulWidget {
  final ValueChanged<String> onChanged, onSubmitted;
  final String label, hint;
  final TextInputType keyboardType;
  final bool autoFoucs;
  final FocusNode focusNode;
  const InputField({
    Key key,
    this.onChanged,
    this.label,
    this.keyboardType = TextInputType.text,
    this.hint,
    this.autoFoucs = false,
    this.focusNode,
    this.onSubmitted,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  FocusNode _myFocusNode;
  @override
  void initState() {
    if (widget.focusNode == null) {
      _myFocusNode = FocusNode();
    } else {
      _myFocusNode = widget.focusNode;
    }
    super.initState();
  }

  @override
  void dispose() {
    _myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Material(
        color: Colors.black.withAlpha(
          10,
        ),
        borderRadius: BorderRadius.circular(
          5,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: TextField(
            onSubmitted: widget.onSubmitted,
            autofocus: widget.autoFoucs,
            focusNode: _myFocusNode,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
              labelStyle: GoogleFonts.nunito(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Colors.orange,
              ),
              hintStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.w800,
              ),
            ),
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w800,
            ),
            cursorColor: Colors.orange,
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}
