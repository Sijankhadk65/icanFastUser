import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/cart_menu_bloc.dart';
import '../models/vendor.dart';
import '../widgets/source_card.dart';
import 'package:provider/provider.dart';

class VendorsScreen extends StatefulWidget {
  final String tag;
  final Map<String, dynamic> user;

  const VendorsScreen({Key key, @required this.tag, this.user})
      : super(key: key);
  @override
  _VendorsScreenState createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen>
    with TickerProviderStateMixin {
  CartMenuBloc _cartMenuBloc;

  @override
  void didChangeDependencies() {
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  AnimationController _hideFabAnimation;

  @override
  void initState() {
    super.initState();
    _hideFabAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  void dispose() {
    _hideFabAnimation.dispose();
    super.dispose();
  }

  final _controller = ScrollController();
  ScrollController _hideButtonController;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        // print(userScroll.metrics);
        print(userScroll.direction);
        if (userScroll.metrics.atEdge == true) {
          _hideFabAnimation.forward();
        } else if (userScroll.metrics.atEdge == false) {
          _hideFabAnimation.reverse();
        }
        // switch (userScroll.direction) {
        //   case ScrollDirection.forward:
        //     if (userScroll.metrics.maxScrollExtent !=
        //         userScroll.metrics.minScrollExtent) {
        //       print("Showing");
        //       _hideFabAnimation.forward();
        //     }
        //     break;
        //   case ScrollDirection.reverse:
        //     if (userScroll.metrics.maxScrollExtent !=
        //         userScroll.metrics.minScrollExtent) {
        //       print("Not Showing");

        //       _hideFabAnimation.reverse();
        //     }
        //     break;
        //   case ScrollDirection.idle:
        //     break;
        // }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    _cartMenuBloc.getVendors(widget.tag);

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        floatingActionButton: ScaleTransition(
          scale: _hideFabAnimation,
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            elevation: 8,
            onPressed: () {},
            backgroundColor: Colors.orange[300],
            child: Icon(Icons.arrow_right),
          ),
        ),
        body: Container(
          child: StreamBuilder<List<Vendor>>(
            stream: _cartMenuBloc.vendors,
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Select lot');
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                  print(widget.tag);
                  return snapshot.data.isNotEmpty
                      ? StreamBuilder<List<String>>(
                          stream: _cartMenuBloc.getFavourites(
                            "resturant",
                            widget.user['email'],
                          ),
                          builder: (context, favouriteSnapshot) {
                            if (favouriteSnapshot.hasError)
                              return Text("${favouriteSnapshot.error}");
                            switch (favouriteSnapshot.connectionState) {
                              case ConnectionState.none:
                                return Text("Awaiting bids...");
                                break;
                              case ConnectionState.waiting:
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                                break;
                              case ConnectionState.active:
                                return ListView(
                                  shrinkWrap: true,
                                  controller: _controller,
                                  children: snapshot.data
                                      .map<Widget>(
                                        (vendor) => Provider(
                                          create: (_) => CartMenuBloc(),
                                          dispose:
                                              (context, CartMenuBloc bloc) =>
                                                  bloc.dispose(),
                                          child: SourceCard(
                                            isFeatured:
                                                favouriteSnapshot.data.contains(
                                              vendor.name,
                                            ),
                                            vendor: vendor,
                                            user: widget.user,
                                            onTap: () {
                                              _cartMenuBloc.toogleFavourite(
                                                favouriteSnapshot.data.contains(
                                                  vendor.name,
                                                ),
                                                "resturant",
                                                widget.user['email'],
                                                {
                                                  "name": vendor.name,
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                                break;
                              case ConnectionState.done:
                                return Text("The Task has complted");
                                break;
                            }
                            return null;
                          },
                        )
                      : Center(
                          child: Text(
                            "No Vendors Found.",
                            style: GoogleFonts.oswald(
                              color: Colors.orange[800],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                case ConnectionState.done:
                  return Text('${snapshot.data} (closed)');
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
