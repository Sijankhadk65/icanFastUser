import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/bloc/login_bloc.dart';
import 'package:fastuserapp/src/widgets/simple_dialog_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileImageSourceDialoge extends StatefulWidget {
  final String email;

  const ProfileImageSourceDialoge({
    Key key,
    this.email,
  }) : super(key: key);
  @override
  _ProfileImageSourceDialogeState createState() =>
      _ProfileImageSourceDialogeState();
}

class _ProfileImageSourceDialogeState extends State<ProfileImageSourceDialoge> {
  LoginBloc _loginBloc;

  @override
  void didChangeDependencies() {
    _loginBloc = Provider.of<LoginBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        "Choose a source for your image.",
        style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black45,
        ),
      ),
      children: [
        SimpleDialogItem(
          icon: Icons.image,
          title: "Gallery",
          subtitle: "Pick an image from your collection.",
          onPressed: () {
            _loginBloc.profileImageUpdater(
              widget.email,
              "gallery",
            );
            Navigator.pop(context);
          },
        ),
        Divider(),
        SimpleDialogItem(
          icon: Icons.camera,
          title: "Camera",
          subtitle: "Take a picture for your profile.",
          onPressed: () {
            _loginBloc.profileImageUpdater(
              widget.email,
              "camera",
            );
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
