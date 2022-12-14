


import 'package:Alaswaq/account/profile/my_account.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/account/login/login_page.dart';
import 'package:Alaswaq/main.dart';
import 'package:Alaswaq/orders/orders.dart';
import 'package:Alaswaq/others/Notifications.dart';
import 'package:Alaswaq/product/Categories/categories.dart';
import 'package:Alaswaq/product/Categories/categoriesList.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;
  var isLogin = false ;
  @override
  void initState() {
    super.initState();
    pageController = PageController();

  }



  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOutSine,
    );
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()async{

          showDialog(
          context: context,
          builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(

          content: new Text("Do you want to exit the app"),
          actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
          child: new Text("No"),
          onPressed: () {
          Navigator.of(context).pop();
          return false;
          },
          ),
          new FlatButton(
          child: new Text("Yes"),
          onPressed: () {
            SystemNavigator.pop();
            return false;
          },
          ),
          ],
          );
          },
          );

          return false;
        },


        child: Scaffold(
          backgroundColor: Colors.white,
          body: PageView(

            children: <Widget>[
              HomePage(),
//          HomePage(),
              (HomePageState.isLogin ) ? OrdersList("from Bottom") : LogInPage(6),
              CategoryPage(),
              (HomePageState.isLogin ) ? MyAccount("from Bottom") : LogInPage(7),
              Notifications()
//              RaisedButton(
//                  child: Text('There is no notifications',
//                  style : TextStyle( fontFamily: 'montserrat', fontSize: 16,color:  Colors.black)), onPressed: null),
            ],
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: onPageChanged,
          ),
          bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75)
                    )
                  ],
                  color: Colors.white
              ),
//    alignment: Alignment.center,
              height: 80,
              child: Padding(
    padding: const EdgeInsets.only(top: 0, bottom: 0, right: 0),
    child: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
                  currentIndex: pageIndex,
      unselectedItemColor: Colors.green,
      selectedItemColor: Colors.yellow,
                  onTap: onTap,
                  items: [
                    BottomNavigationBarItem(
//            icon: Icon(Icons.home,size: 30,),

                      icon: Container(
//                  padding: EdgeInsets.only(top: 5),
                        //margin: EdgeInsets.only(top: 10.0),
//                width: 30.0,
//                height: 30.0,
                          child: Image.asset(
                            'assets/images/icons/home.png',
//                  width: 40.0,
                            height: 15.0,
                    color: (pageIndex == 0) ? HexColor("302c98") : Colors.black,
                          )),

                      title: Text('Home',style: TextStyle( fontFamily: 'montserrat', fontSize: 12,color: (pageIndex == 0) ? HexColor("302c98") : Colors.black)),
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
//                  padding: EdgeInsets.only(top: 5),
                        //margin: EdgeInsets.only(top: 10.0),
//                width: 30.0,
//                height: 30.0,
                          child: Image.asset(
                            'assets/images/icons/orders.png',
//                  width: 40.0,
                            height: 15.0,
                  color: (pageIndex == 1) ? HexColor("302c98") : Colors.black,
                          )),
                      title: Text('Orders',style: TextStyle( fontFamily: 'montserrat', fontSize: 12,color: (pageIndex == 1) ? HexColor("302c98") : Colors.black)),
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
//                  padding: EdgeInsets.only(top: 5),
                        //margin: EdgeInsets.only(top: 10.0),
//                width: 30.0,
//                height: 30.0,
                          child: Image.asset(
                            'assets/images/icons/category-icon.png',
//                  width: 40.0,
                            height: 15.0,
                  color: (pageIndex == 2) ? HexColor("302c98") : Colors.black,
                          )),
                      title: Text('Categories',style: TextStyle( fontFamily: 'montserrat', fontSize: 12,color: (pageIndex == 2) ? HexColor("302c98") : Colors.black)),
                    ),
                    BottomNavigationBarItem(
                        icon: Container(
//                    padding: EdgeInsets.only(top: 5),
//                  width: 30.0,
//                  height: 30.0,
                            child: Image.asset(
                              'assets/images/icons/profile.png',
//                    width: 40.0,
                              height: 15.0,
                    color: (pageIndex == 3) ? HexColor("302c98") : Colors.black,
                            )),
                        title: Text('Profile',style: TextStyle( fontFamily: 'montserrat', fontSize: 12,color: (pageIndex == 3) ? HexColor("302c98") : Colors.black))
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
//                  padding: EdgeInsets.only(top: 5),
                        //margin: EdgeInsets.only(top: 10.0),
//                width: 30.0,
//                height: 30.0,
                          child: Image.asset(
                            'assets/images/icons/notifications.png',
//                  width: 40.0,
                            height: 15.0,
                    color: (pageIndex == 4) ? HexColor("302c98") : Colors.black,
                          )),
                      title: Text('Notification',style: TextStyle( fontFamily: 'montserrat', fontSize: 12,color: (pageIndex == 4) ? HexColor("302c98") : Colors.black),),
                    ),
                  ],
                ),
              )
          ),
        )

    );

  }

  }






