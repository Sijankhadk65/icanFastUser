import 'package:fastuserapp/src/bloc/cart_menu_bloc.dart';
import 'package:fastuserapp/src/models/community_item.dart';
import 'package:fastuserapp/src/screens/community_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommunityCard extends StatelessWidget {
  final String title, description, assetPath;
  final CommunityItem communityItem;
  final double iconSize;
  final Function() onTap;
  final Map<String, dynamic> user;

  const CommunityCard(
      {Key key,
      this.title,
      this.description,
      this.assetPath,
      this.iconSize,
      this.onTap,
      this.communityItem,
      this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Provider(
              create: (_) => CartMenuBloc(),
              child: CommunityDetailScreen(
                communityItem: communityItem,
                user: user,
              ),
            ),
          ),
        )
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(assetPath),
              ),
              SizedBox(height: 15),
              Text(
                title,
                style: TextStyle(fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
    // return Container(
    //   margin: EdgeInsets.only(
    //     top: 5,
    //     left: 5,
    //     right: 5,
    //     bottom: 15,
    //   ),
    //   child: Stack(
    //     children: [
    //       Container(
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           image: DecorationImage(
    //             image: AssetImage(assetPath),
    //             fit: BoxFit.cover,
    //           ),
    //           borderRadius: BorderRadius.circular(
    //             5,
    //           ),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.black12,
    //               blurRadius: 5,
    //               offset: Offset(
    //                 0,
    //                 8,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //       Container(
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(
    //             5,
    //           ),
    //           gradient: LinearGradient(
    //             begin: Alignment.topCenter,
    //             end: Alignment.bottomCenter,
    //             colors: [
    //               Colors.transparent,
    //               Colors.transparent,
    //               Colors.black,
    //               Colors.black87
    //             ],
    //           ),
    //         ),
    //         child: Material(
    //           color: Colors.transparent,
    //           child: InkWell(
    //             onTap: onTap,
    //             borderRadius: BorderRadius.circular(
    //               13,
    //             ),
    //             splashColor: Colors.orange[300],
    //             child: Padding(
    //               padding: EdgeInsets.only(
    //                 left: 15,
    //                 right: 15,
    //                 top: 8,
    //                 bottom: 8,
    //               ),
    //               child: Row(
    //                 children: [
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.end,
    //                       children: <Widget>[
    //                         Text(
    //                           title,
    //                           style: GoogleFonts.nunito(
    //                             fontWeight: FontWeight.w800,
    //                             color: Colors.white,
    //                             fontSize: 16,
    //                           ),
    //                         ),
    //                         Text(
    //                           description,
    //                           style: GoogleFonts.montserrat(
    //                             fontSize:
    //                                 MediaQuery.of(context).size.height < 1080
    //                                     ? 8
    //                                     : 11,
    //                             fontWeight: FontWeight.w600,
    //                             color: Colors.white.withAlpha(
    //                               200,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
