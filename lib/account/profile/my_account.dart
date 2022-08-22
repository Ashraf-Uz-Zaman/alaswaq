import 'dart:convert';
import 'dart:io';
import 'package:Alaswaq/Model/register_model.dart';
import 'package:Alaswaq/account/profile/edit_my_account.dart';
import 'package:Alaswaq/home/home_page_new.dart';
<<<<<<< HEAD
import 'package:Alaswaq/payment/review_and_payments.dart';
import 'package:Alaswaq/utils/constants.dart';
=======
>>>>>>> november_1
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyAccount extends StatefulWidget {
  String fromPage = "" ;
  MyAccount( this.fromPage);
  @override
  MyAccountState createState() => MyAccountState();
}

class MyAccountState extends State<MyAccount> {
  GlobalKey<FormState> _formKey = GlobalKey();
  static var userName = "";
  static var phoneNum = "";
  static var isloggedIn = false;
  static List<String> street = new List<String>();
  static var city = "";
  static var password = "";
  static var emailid = "";
  static var postalCode = "";

//  UserRegistration userreg_model;

  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getUserInfo();
    });
  }

  Container showDetails({String text, String text2,}) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              color: Colors.grey,
              child: Container(
                height: 50,
                padding: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Card(
//                color: Colors.blue,
              child: Container(
                height: 50,
                padding: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text2,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,

        // hides leading widget
//        flexibleSpace: Container(),
<<<<<<< HEAD
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Text(
          'My Account',
          style: TextStyle(
=======
        leading: widget.fromPage != "from Bottom" ?  IconButton(
            icon:  Icon( Icons.keyboard_backspace, color: Colors.black, size: 40,),
            onPressed: () {
              if(widget.fromPage == "from Login") {
                print( widget.fromPage);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              } else {
                print( widget.fromPage);
                Navigator.of(context).pop();

              }
            }



        ) : Container(),

        title: Text(
          'My Account',
          style: TextStyle( fontFamily: 'montserrat',
>>>>>>> november_1
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.border_color,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditMyAccount()));
              })
        ],
      ),
<<<<<<< HEAD
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Padding(
            padding:
            EdgeInsets.only(left: 10.0, top: 15, bottom: 15, right: 10),
            child: Column(
              children: <Widget>[
                showDetails(
                    text: 'Name:', text2: userName == null ? 'Null' : userName),
                verticalSpace(),
                showDetails(
                    text: 'Email:', text2: emailid == null ? 'Null' : emailid),
                verticalSpace(),
                showDetails(
                    text: 'Password:',
                    text2: password == null ? 'Null' : "************"),
                verticalSpace(),
                showDetails(
                    text: 'Mobile:',
                    text2: phoneNum == null ? 'Null' : phoneNum),
                verticalSpace(),
                showDetails(
                    text: 'Street:',
                    text2: street == null ? 'Null' : street.toString()),
                verticalSpace(),
                showDetails(
                    text: 'Postal Code:',
                    text2: postalCode == null ? 'Null' : postalCode),
                verticalSpace(),
                showDetails(text: 'City:', text2: city == null ? 'Null' : city),
              ],
            ),
=======
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, top: 15,bottom: 15, right: 20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Name',
                    style: TextStyle( fontFamily: 'montserrat', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,),
                  ),
                  SizedBox(

                    child:
                    FlatButton(

                      onPressed: () async {
//                        Navigator.pushReplacement(
//                          context,
//                          MaterialPageRoute(
//                            builder: (context) => EditName(),
//                          ),
//                        );
                      },

                      child:
                      Row(
                        children: [
                          Text(userName, style: TextStyle( fontFamily: 'montserrat', 
                              color:  Colors.black, fontSize: 16, fontWeight: FontWeight.w400,
                          )
                          ),
//                          Icon(Icons.chevron_right)
                        ],
                      ),
//                              textColor: MyColors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.white,
                          width: 0.5,
                          style: BorderStyle.solid
                      ), borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Email',
                    style: TextStyle( fontFamily: 'montserrat', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,),
                  ),
                  SizedBox(

                    child:
                    FlatButton(
                      onPressed: () async {
//                        Navigator.pushReplacement(
//                          context,
//                          MaterialPageRoute(builder: (context) => EditProfileField("Change Email")),
//
//                        );
                      },
                      child:
                      Row(
                        children: [
                          Text(emailid, style: TextStyle( fontFamily: 'montserrat', 
                              color:  Colors.black, fontSize: 16, fontWeight: FontWeight.w400,
                          )
                          ),
//                          Icon(Icons.chevron_right)
                        ],
                      ),
//                              textColor: MyColors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.white,
                          width: 0.5,
                          style: BorderStyle.solid
                      ), borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
//                  Text(
//                    'Mobile',
//                    style: TextStyle( fontFamily: 'montserrat', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,),
//                  ),
//                  SizedBox(
//
//                    child:
//                    FlatButton(
//                      onPressed: () async {
////                        Navigator.pushReplacement(
////                          context,
////                          MaterialPageRoute(builder: (context) => EditMobile()),
////                        );
//                      },
//                      child:
//                      Row(
//                        children: [
//                        ],
//                      ),
////                              textColor: MyColors.white,
//                      shape: RoundedRectangleBorder(side: BorderSide(
//                          color: Colors.white,
//                          width: 0.5,
//                          style: BorderStyle.solid
//                      ), borderRadius: BorderRadius.circular(5)),
//                    ),
//                  ),
                ],
              ),
              Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Password',
                    style: TextStyle( fontFamily: 'montserrat', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,),
                  ),
                  SizedBox(

                    child:
                    FlatButton(
                      onPressed: () async {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => EditPassword(password)),
//                        );
                      },
                      child:
                      Row(
                        children: [
                          Text('............', style: TextStyle( fontFamily: 'montserrat',
                              color:  Colors.black, fontSize: 16, fontWeight: FontWeight.w400,
                          )
                          ),
//                          Icon(Icons.chevron_right)
                        ],
                      ),
//                              textColor: MyColors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.white,
                          width: 0.5,
                          style: BorderStyle.solid
                      ), borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 1,
              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                    'Address',
//                    style: TextStyle( fontFamily: 'montserrat', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,),
//                  ),
//                  SizedBox(
//
//                    child:
//                    FlatButton(
//                      onPressed: () async {
////                        Navigator.push(
////                          context,
////                          MaterialPageRoute(builder: (context) => EditProfileField("Change Address")),
////                        );
//                      },
//                      child:
//                      Row(
//                        children: [
//                          Text("city", style: TextStyle( fontFamily: 'montserrat',
//                              color:  Colors.black, fontSize: 16, fontWeight: FontWeight.w400,
//                          )
//                          ),
////                          Icon(Icons.chevron_right)
//                        ],
//                      ),
////                              textColor: MyColors.white,
//                      shape: RoundedRectangleBorder(side: BorderSide(
//                          color: Colors.white,
//                          width: 0.5,
//                          style: BorderStyle.solid
//                      ), borderRadius: BorderRadius.circular(5)),
//                    ),
//                  ),
//                ],
//              ),
              Divider(
                height: 1,
              ),

            ],
>>>>>>> november_1
          ),
        ),
      ),
    );
  }

  Future<bool> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('firstname');
      phoneNum = prefs.getString('phone');
      street = prefs.getStringList('street');
      city = prefs.getString('city');
      password = prefs.getString('password');
      emailid = prefs.getString('email');
      postalCode = prefs.getString('postalCode');
    });
  }
}

//import 'package:Alaswaq/account/profile/edit_my_account.dart';
//import 'package:Alaswaq/utils/style/color.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//class MyAccount extends StatefulWidget {
//  @override
//  _MyAccountState createState() => _MyAccountState();
//}
//
//class _MyAccountState extends State<MyAccount> {
//  static var userName =  "";
//  static var phoneNum =  "";
//  static var isloggedIn = false;
//  List<String >street = new List<String>();
//  var city = "" ;
//  var password = "" ;
//  var emailid = "" ;
//  void initState()  {
//    super.initState();
//    SchedulerBinding.instance.addPostFrameCallback((_) async {
//      await getUserInfo();
//    });
//
//  }
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: AppColor.whiteColor,
//        centerTitle: true,
//        automaticallyImplyLeading: false,
//        // hides leading widget
////        flexibleSpace: Container(),
//        leading: GestureDetector(
//          onTap: ()=>Navigator.pop(context),
//          child: Icon(
//            Icons.keyboard_backspace,
//            color: Colors.black,
//            size: 30,
//          ),
//        ),
//        title: Text(
//          'My Account',
//          style: TextStyle(
//              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
//        ),
//        actions: [
//          IconButton(icon: Icon(Icons.border_color,color: Colors.black,size: 20,), onPressed: (){
//            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditMyAccount()));
//          })
//        ],
//      ),
//      body:Container(
//        width: MediaQuery.of(context).size.width,
//        height: MediaQuery.of(context).size.height,
//        color: Colors.white,
//        child: Padding(
//          padding: EdgeInsets.only(left: 20.0, top: 15,bottom: 15, right: 20),
//          child: Column(
//            children: <Widget>[
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                    'Name',
//                    style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'lato'),
//                  ),
//                  SizedBox(
//
//                    child:
//                    FlatButton(
//
//                      onPressed: () async {
////                        Navigator.pushReplacement(
////                          context,
////                          MaterialPageRoute(
////                            builder: (context) => EditName(),
////                          ),
////                        );
//                      },
//
//                      child:
//                      Row(
//                        children: [
//                          Text(userName, style: TextStyle(
//                              color:  Colors.black, fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'lato'
//                          )
//                          ),
////                          Icon(Icons.chevron_right)
//                        ],
//                      ),
////                              textColor: MyColor.white,
//                      shape: RoundedRectangleBorder(side: BorderSide(
//                          color: Colors.white,
//                          width: 0.5,
//                          style: BorderStyle.solid
//                      ), borderRadius: BorderRadius.circular(5)),
//                    ),
//                  ),
//                ],
//              ),
//              Divider(
//                height: 1,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                    'Email',
//                    style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'lato'),
//                  ),
//                  SizedBox(
//
//                    child:
//                    FlatButton(
//                      onPressed: () async {
////                        Navigator.pushReplacement(
////                          context,
////                          MaterialPageRoute(builder: (context) => EditProfileField("Change Email")),
////
////                        );
//                      },
//                      child:
//                      Row(
//                        children: [
//                          Text(emailid, style: TextStyle(
//                              color:  Colors.black, fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'lato'
//                          )
//                          ),
////                          Icon(Icons.chevron_right)
//                        ],
//                      ),
////                              textColor: MyColor.white,
//                      shape: RoundedRectangleBorder(side: BorderSide(
//                          color: Colors.white,
//                          width: 0.5,
//                          style: BorderStyle.solid
//                      ), borderRadius: BorderRadius.circular(5)),
//                    ),
//                  ),
//                ],
//              ),
//              Divider(
//                height: 1,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                    'Mobile',
//                    style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'lato'),
//                  ),
//                  SizedBox(
//
//                    child:
//                    FlatButton(
//                      onPressed: () async {
////                        Navigator.pushReplacement(
////                          context,
////                          MaterialPageRoute(builder: (context) => EditMobile()),
////                        );
//                      },
//                      child:
//                      Row(
//                        children: [
////                          Text(phoneNum, style: TextStyle(
////                              color:  Colors.black, fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'lato'
////                          )
////                          ),
////                          Icon(Icons.chevron_right)
//                        ],
//                      ),
////                              textColor: MyColor.white,
//                      shape: RoundedRectangleBorder(side: BorderSide(
//                          color: Colors.white,
//                          width: 0.5,
//                          style: BorderStyle.solid
//                      ), borderRadius: BorderRadius.circular(5)),
//                    ),
//                  ),
//                ],
//              ),
//              Divider(
//                height: 1,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                    'Password',
//                    style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'lato'),
//                  ),
//                  SizedBox(
//
//                    child:
//                    FlatButton(
//                      onPressed: () async {
////                        Navigator.push(
////                          context,
////                          MaterialPageRoute(builder: (context) => EditPassword(password)),
////                        );
//                      },
//                      child:
//                      Row(
//                        children: [
//                          Text('............', style: TextStyle(
//                              color:  Colors.black, fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'lato'
//                          )
//                          ),
////                          Icon(Icons.chevron_right)
//                        ],
//                      ),
////                              textColor: MyColor.white,
//                      shape: RoundedRectangleBorder(side: BorderSide(
//                          color: Colors.white,
//                          width: 0.5,
//                          style: BorderStyle.solid
//                      ), borderRadius: BorderRadius.circular(5)),
//                    ),
//                  ),
//                ],
//              ),
//              Divider(
//                height: 1,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                    'Address',
//                    style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'lato'),
//                  ),
//                  SizedBox(
//
//                    child:
//                    FlatButton(
//                      onPressed: () async {
////                        Navigator.push(
////                          context,
////                          MaterialPageRoute(builder: (context) => EditProfileField("Change Address")),
////                        );
//                      },
//                      child:
//                      Row(
//                        children: [
//                          Text("city", style: TextStyle(
//                              color:  Colors.black, fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'lato'
//                          )
//                          ),
////                          Icon(Icons.chevron_right)
//                        ],
//                      ),
////                              textColor: MyColor.white,
//                      shape: RoundedRectangleBorder(side: BorderSide(
//                          color: Colors.white,
//                          width: 0.5,
//                          style: BorderStyle.solid
//                      ), borderRadius: BorderRadius.circular(5)),
//                    ),
//                  ),
//                ],
//              ),
//              Divider(
//                height: 1,
//              ),
//
//            ],
//          ),
//        ),
//      ),
//
//    );
//  }
//
//  Future<bool> getUserInfo() async {
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//
//  setState(() {
//    userName =   prefs.getString('firstname');
//    phoneNum =  prefs.getString('phone');
//    street =   prefs.getStringList('street');
//    city =  prefs.getString('city');
//    password =  prefs.getString('password');
//    emailid = prefs.getString('email');
//  }
//
//  );
//
//
//
//  }
//}
