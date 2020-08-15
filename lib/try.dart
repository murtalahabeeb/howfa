import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:howfa/FriendsModel.dart';
import 'package:howfa/friends.dart';
import 'package:howfa/home.dart';
import 'package:howfa/resgister.dart';
import 'package:howfa/welcome.dart';
class explore extends StatefulWidget {
  @override
  _exploreState createState() => _exploreState();
}

class _exploreState extends State<explore> {
  int _page=0;
  int page2=0;
  PageController _controller = PageController();
  PageController _controller2 = PageController();
  ScrollController con = ScrollController();
  var f;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((f){
      setState(() {
        this.f=f;
        _controller=PageController(initialPage:_page,viewportFraction: 1);
        _controller=PageController(initialPage:0,viewportFraction: 1);
      });
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.amber,
        padding: EdgeInsets.all(10.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
            body:Stack(
                children: <Widget>[

                      PageView(

                        physics: NeverScrollableScrollPhysics(),
                        controller: _controller,
                        onPageChanged:change ,
                        children: <Widget>[
                          PageView(
                            reverse: true,
                            children: <Widget>[
                              home(),
                              Friends(f)
                            ],
                          ),
                          Container(color: Colors.greenAccent,child: Center(child: Text("world"))),
                        ],
                      ),

                  Positioned(
                    bottom: 20,
                    child: Column(
                      children: <Widget>[
                        popula(0),
                        popular(1),

                      ],
                    ),
                  )
                ],
              ),
        ),
      ),
    );
  }
  popular(int page){
    return IconButton(icon: Icon(Icons.threesixty), onPressed:(){
      _controller.jumpToPage(page);
    });

  }
  popula(int page){
    return IconButton(icon: Icon(Icons.pages), onPressed:(){
      _controller.jumpToPage(page);
    });

  }
  change(int page){
    setState(() {
      _page=page;
    });

  }
  change2(int page){
    setState(() {
      page2=page;
    });

  }
}