import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/ratings_bloc.dart';
import '../models/rating.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final String vendorName;

  const RatingScreen({
    Key key,
    this.user,
    this.vendorName,
  }) : super(key: key);
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  RatingsBloc _ratingsBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _ratingsBloc = Provider.of<RatingsBloc>(context);
    _ratingsBloc.changeSavingStatus(false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _ratingsBloc.getRatings(widget.vendorName);
    return Scaffold(
      appBar: AppBar(
        title: Text("Ratings"),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<double>(
                    stream: _ratingsBloc.ratingValue,
                    builder: (context, snapshot) {
                      return SmoothStarRating(
                        allowHalfRating: true,
                        color: Colors.yellow[800],
                        borderColor: Colors.yellow[800],
                        spacing: 2,
                        size: 30,
                        onRated: _ratingsBloc.changeRatingValue,
                      );
                    },
                  ),
                ),
                StreamBuilder<bool>(
                  initialData: false,
                  stream: _ratingsBloc.isSaving,
                  builder: (context, snapshot) {
                    return snapshot.data
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : StreamBuilder<bool>(
                            stream: _ratingsBloc.canSubmitRating(),
                            builder: (context, snapshot) {
                              return RawMaterialButton(
                                fillColor: Colors.orange[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onPressed: snapshot.hasData
                                    ? () {
                                        _ratingsBloc.changeSavingStatus(
                                          true,
                                        );
                                        _ratingsBloc
                                            .saveRating(
                                              widget.vendorName,
                                              widget.user,
                                            )
                                            .whenComplete(
                                              () => _ratingsBloc
                                                  .changeSavingStatus(
                                                false,
                                              ),
                                            );
                                      }
                                    : null,
                                elevation: 5,
                                disabledElevation: 0,
                                child: Text(
                                  "Submit",
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),
              ],
            ),
            StreamBuilder<String>(
                stream: _ratingsBloc.ratingComment,
                builder: (context, snapshot) {
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Comment",
                          style: GoogleFonts.montserrat(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.all(5),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            child: TextField(
                              maxLines: 5,
                              onChanged: _ratingsBloc.changeRatingComment,
                              style: GoogleFonts.nunito(),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Customer Comments:",
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    StreamBuilder<List<Rating>>(
                      stream: _ratingsBloc.ratings,
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
                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data
                                  .map(
                                    (rating) => Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Divider(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                rating.user.name.toUpperCase(),
                                                style: GoogleFonts.oswald(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                                width: 5,
                                              ),
                                              Text(
                                                "(${rating.rating.toString()})",
                                                style: GoogleFonts.nunito(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(rating.comment),
                                          Divider(),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                            break;
                          case ConnectionState.done:
                            return Text("The task has been completed.");
                            break;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
