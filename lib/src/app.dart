import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './root.dart';
import './bloc/login_bloc.dart';

import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelPadding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 15,
            right: 15,
          ),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.orange[500],
          ),
          labelStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
          unselectedLabelStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          // labelStyle: GoogleFonts.montserrat(
          //   fontWeight: FontWeight.w600,
          // ),
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
            headline6: GoogleFonts.nunito(
              color: Colors.black,
              // fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
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
