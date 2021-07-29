import 'package:fastuserapp/src/bloc/cart_menu_bloc.dart';
import 'package:fastuserapp/src/models/community_item.dart';
import 'package:fastuserapp/src/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'vendors_screen.dart';

class CommunityDetailScreen extends StatefulWidget {
  final CommunityItem communityItem;
  final Map<String, dynamic> user;

  CommunityDetailScreen({this.communityItem, this.user});

  @override
  _CommunityDetailScreenState createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  CartMenuBloc _cartMenuBloc;
  @override
  void didChangeDependencies() {
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _cartMenuBloc.getTags();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.communityItem.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        tileMode: TileMode.clamp,
                        colors: [
                          Colors.black,
                          Colors.black,
                        ]),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.dstOut),
                        image: NetworkImage(
                          widget.communityItem.photoURI,
                        )),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50.0))),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.communityItem.title,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(FlutterIcons.map_marker_mco, color: Colors.black),
                        Text(
                          widget.communityItem.city,
                          style: TextStyle(
                              color: Color(0xffc4c4c4),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Description:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${widget.communityItem.description}",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Products:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 500,
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
                                        tabBuilder: (context, index) => Text(
                                            snapshot.data[index].toUpperCase()),
                                        pageBuilder: (context, index) =>
                                            Provider(
                                          create: (_) => CartMenuBloc(),
                                          child: VendorsScreen(
                                            tag: snapshot.data[index],
                                            user: widget.user,
                                          ),
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
