import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './root.dart';
import './bloc/login_bloc.dart';

import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IRM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        tabBarTheme: TabBarTheme(
          labelColor: Colors.orange[600],
          unselectedLabelColor: Colors.black,
          labelPadding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 15,
            right: 15,
          ),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(
              width: 2,
              color: Colors.orange[800],
            ),
          ),
          labelStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
          unselectedLabelStyle: GoogleFonts.montserrat(
            fontSize: 15,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
          ),
          hintStyle: GoogleFonts.nunito(
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Colors.transparent,
          elevation: 0.0,
          textTheme: TextTheme(
            headline6: GoogleFonts.oswald(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                letterSpacing: 2),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Provider(
        create: (_) => LoginBloc(),
        dispose: (context, LoginBloc bloc) => bloc.dispose(),
        child: Root(),
      ),
    );
  }
}
