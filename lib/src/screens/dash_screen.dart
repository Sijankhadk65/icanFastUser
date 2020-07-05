import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fastuserapp/src/bloc/cart_menu_bloc.dart';
import 'package:fastuserapp/src/bloc/dash_bloc.dart';
import 'package:fastuserapp/src/models/carousel_item.dart';
import 'package:fastuserapp/src/screens/vendors_screen.dart';
import 'package:fastuserapp/src/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const DashScreen({Key key, this.user}) : super(key: key);
  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  DashBloc _dashBloc;
  CartMenuBloc _cartMenuBloc;

  @override
  void didChangeDependencies() {
    _dashBloc = Provider.of<DashBloc>(context);
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _cartMenuBloc.getTags();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: StreamBuilder<List<CarouselItem>>(
              stream: _dashBloc.getCarouselItems(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text("Error:${snapshot.error}");
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text("Awaiting Bids....");
                    break;
                  case ConnectionState.waiting:
                    return Center(
                      child: Center(child: CircularProgressIndicator()),
                    );
                    break;
                  case ConnectionState.active:
                    return CarouselSlider.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => CachedNetworkImage(
                        imageUrl: snapshot.data[index].photoURI,
                        progressIndicatorBuilder: (context, msg, progress) =>
                            CircularProgressIndicator(),
                        imageBuilder: (context, imageProvider) => Container(
                          margin: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, msg, error) => Container(
                          margin: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      options: CarouselOptions(
                        aspectRatio: 16 / 7,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    );

                    break;
                  case ConnectionState.done:
                    return Text("The task has completed");
                    break;
                }
                return null;
              },
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: StreamBuilder<List<String>>(
                          stream: _cartMenuBloc.tags,
                          builder: (context, snapshot) {
                            if (snapshot.hasError)
                              return Text("Error: ${snapshot.error}");
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Text("Awaiting Bids....");
                                break;
                              case ConnectionState.waiting:
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                                break;
                              case ConnectionState.active:
                                return CustomTabView(
                                  itemCount: snapshot.data.length,
                                  tabBuilder: (context, index) =>
                                      Text(snapshot.data[index].toUpperCase()),
                                  pageBuilder: (context, index) => Provider(
                                    create: (_) => CartMenuBloc(),
                                    child: VendorsScreen(
                                        tag: snapshot.data[index],
                                        user: widget.user),
                                  ),
                                );
                                break;
                              case ConnectionState.done:
                                return Text("The task has completed");
                                break;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
