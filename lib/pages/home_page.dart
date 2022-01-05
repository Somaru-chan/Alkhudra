import 'package:carousel_slider/carousel_slider.dart';
import 'package:companies_alkhudra/Constant/locale_keys.dart';
import 'package:companies_alkhudra/designs/drawer_design.dart';
import 'package:companies_alkhudra/designs/greeting_text.dart';
import 'package:companies_alkhudra/designs/product_card.dart';
import 'package:companies_alkhudra/designs/search_bar.dart';
import 'package:companies_alkhudra/designs/text_field_design.dart';
import 'package:companies_alkhudra/dialogs/two_btns_dialog.dart';
import 'package:companies_alkhudra/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'add_branches_page.dart';
import 'contact_us.dart';
import 'edit_profile.dart';
import 'language_setting.dart';


class HomePage extends StatefulWidget {
  final bool isHasBranch;
  const HomePage({Key? key, required this.isHasBranch}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  //------------------------

   void showAddBranchDialog() async {
     await Future.delayed(Duration(milliseconds: 50));
     List<Function()> actions = [
       () {
         addBranchesPage();
         //   Navigator.pop(context);
       },
       () {
         Navigator.pop(context);
       }
     ];
     showDialog<String>(
         context: context,
         builder: (BuildContext context) => showTwoBtnDialog(
             context,
             LocaleKeys.add_branch.tr(),
             LocaleKeys.add_branch_note_dialog.tr(),
             LocaleKeys.add_branch_now.tr(),
             LocaleKeys.later.tr(),
             actions));
   }
 ////---------------------------
   void addBranchesPage() {
     Navigator.pop(context);
     Navigator.push(context, MaterialPageRoute(builder: (context) {
       return AddBranchesPage();
     }));
   }
   ////---------------------------
   @override
   void initState() {
     super.initState();

     //todo: show after calling api
     if (widget.isHasBranch == false) {
       showAddBranchDialog();
     }
   }

  // final imgList = [
  //   'https://images.unsplash.com/photo-1575218823251-f9d243b6f720?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8dmVnZXRhYmxlc3xlbnwwfDB8MHx8&auto=format&fit=crop&w=700&q=60',
  //   'https://images.unsplash.com/photo-1562347810-18a0d370ba36?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fGZydWl0c3xlbnwwfDB8MHx8&auto=format&fit=crop&w=700&q=60',
  //   'https://images.unsplash.com/photo-1522184216316-3c25379f9760?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHZlZ2V0YWJsZXN8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=700&q=60',
  //   'https://images.unsplash.com/photo-1563699498778-aa8246fa5456?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzN8fHZlZ2V0YWJsZXN8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=700&q=60',
  //   'https://images.unsplash.com/photo-1583507171283-0d663f8416c8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fHZlZ2V0YWJsZXxlbnwwfDB8MHx8&auto=format&fit=crop&w=700&q=60',
  //   'https://images.unsplash.com/photo-1562051725-cc35a65c8227?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mzl8fGZydWl0c3xlbnwwfDB8MHx8&auto=format&fit=crop&w=700&q=60',
  // ];

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width; 
    double scHeight = size.height;

    return SafeArea(
          child: Scaffold(
            key: _scaffoldState,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //greeting user
                  Container( 
                    child: greeting(context),
                  ),
                  SizedBox(height: 10,),
                  //row of: menu bar + search bar + search button
                  Container(
                    child: searchBar(searchController),
                  ),
                  SizedBox(height: 20,),
                  //image slideshow, commented till client requests
                    
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: MediaQuery.of(context).size.height/4,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(40),
                  //   ),
                  //   child: Center(
                  //     //Image slideshow
                  //     //could replace images with different urls in imgList
                  //     child: Stack(
                  //       children: [
                  //         CarouselSlider.builder(
                  //           //number of images
                  //           itemCount: imgList.length, 
                  //           itemBuilder: (context, index, realIndex) {
                  //             final urlImage = imgList[index];
                  //             return buildImg(urlImage, index);
                  //           }, 
                  //           options: CarouselOptions(
                  //             // pageSnapping: false,
                  //             // enableInfiniteScroll: false,
                  //             height: 200,
                  //             autoPlay: true,
                  //             // enlargeCenterPage: true,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 10,), 
                  Container(
                    width: scWidth*15,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(LocaleKeys.categories.tr(), 
                    style: TextStyle(
                      color: CustomColors().darkBlueColor,
                      fontSize: 22, 
                      fontWeight: FontWeight.w700,
                    ),),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/fruitsnveg.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/fruits.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/veg.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: scWidth*0.4,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Text(LocaleKeys.trending_deals.tr(), 
                        style: TextStyle(
                          color: CustomColors().darkBlueColor,
                          fontSize: 22, 
                          fontWeight: FontWeight.w700,
                        ),),
                      ),
                      SizedBox(width: scWidth*0.35,),
                      Container(
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios,
                            color: CustomColors().primaryGreenColor,),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  productCard(context, 0, 'Avocado', 22),
                  Divider(
                    thickness: 5,
                    color: CustomColors().grayColor,
                  ),
                  productCard(context, 0, 'Melons', 6.95),
                  Divider(
                    thickness: 5,
                    color: CustomColors().grayColor,
                  ),
                  productCard(context, 0, 'Carrots',8.56),
                  Divider(
                    thickness: 5,
                    color: CustomColors().grayColor,
                  ),
                ],
              ),
            ),
            drawer: drawerDesign(context),
            //   drawer: Drawer(
            //     child: ListView(
            //     children: [
            //       Container(
            //         width: 100,
            //         height: 300,
            //         decoration: BoxDecoration(
            //           color: CustomColors().primaryGreenColor,
            //           borderRadius: BorderRadius.only(
            //             bottomLeft: Radius.circular(60),
            //             bottomRight: Radius.circular(60),
            //           ),
            //         ),
            //         child: Column(
            //           children: [
            //             Container(
            //               width: 100,
            //               height: 100,
            //               margin: EdgeInsets.only(top: 40),
            //               child: CircleAvatar(
            //                 backgroundImage: AssetImage('images/male_avatar.png'),
            //               ),
            //             ),
            //             SizedBox(height: 20,),
            //             Container(
            //               //TODO: replace with company variable from DB
            //               child: Text('Company Name', style: TextStyle(
            //                 color: CustomColors().primaryWhiteColor,
            //                 fontSize: 21,
            //                 fontWeight: FontWeight.w600,
            //               ),),
            //             ),
            //             SizedBox(height: 10,),
            //             Container(
            //               //TODO: replace with email variable from DB
            //               child: Text('company@email.com', style: TextStyle(
            //                 color: CustomColors().primaryWhiteColor,
            //                 fontSize: 15,
            //                 fontWeight: FontWeight.w300,
            //               ),),
            //             ),
            //             SizedBox(height: 20,),
            //             GestureDetector(
            //               onTap: () {
            //                 Navigator.pop(context);
            //                 Navigator.push(context, MaterialPageRoute(
            //                   builder: (context) => EditProfile())
            //                 );
            //               },
            //               child: Container(
            //                 width: 120,
            //                 height: 40,
            //                 decoration: BoxDecoration(
            //                   color: CustomColors().primaryWhiteColor,
            //                   borderRadius: BorderRadius.circular(40),
            //                 ),
            //                 child: Center(child: Text(LocaleKeys.edit_profile.tr(),
            //                 style: TextStyle(color: CustomColors().primaryGreenColor,
            //                 fontWeight: FontWeight.w700),)),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       ListTile(
            //         title: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Container(
            //               width: 40,
            //               height: 40,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 color: CustomColors().languageBG
            //               ),
            //               child: Icon(Icons.language, color: CustomColors().language,),
            //             ),
            //             SizedBox(width: 10,),
            //             Text(LocaleKeys.languages.tr(), style: TextStyle(
            //               fontSize: 15,
            //               fontWeight: FontWeight.w500,
            //             ),),
            //           ],
            //         ),
            //         onTap: () {
            //           Navigator.pop(context);
            //           Navigator.push(context, 
            //           MaterialPageRoute(
            //             builder: (context) => LanguageSetting()
            //             ),
            //           );
            //         },
            //       ),
            //       Divider(
            //         thickness: 2.5,
            //       ),
            //       ListTile(
            //         title: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Container(
            //               width: 40,
            //               height: 40,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 color: CustomColors().contactBG,
            //               ),
            //               child: Icon(Icons.verified_user_rounded, color: CustomColors().contact,),
            //             ),
            //             SizedBox(width: 10,),
            //             Text(LocaleKeys.contact_us.tr(), style: TextStyle(
            //               fontSize: 15,
            //               fontWeight: FontWeight.w500,
            //             ),),
            //           ],
            //         ),
            //         onTap: () {
            //           Navigator.pop(context);
            //           Navigator.push(context, 
            //           MaterialPageRoute(
            //             builder: (context) => ContactUs()
            //             ),
            //           );
            //         },
            //       ),
            //       Divider(
            //         thickness: 2.5,
            //       ),
            //       ListTile(
            //         title: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Container(
            //               width: 40,
            //               height: 40,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 color: CustomColors().logOutBG
            //               ),
            //               child: Icon(Icons.logout, color: CustomColors().logOut,),
            //             ),
            //             SizedBox(width: 10,),
            //             Text(LocaleKeys.log_out.tr(), style: TextStyle(
            //               fontSize: 15,
            //               fontWeight: FontWeight.w500,
            //             ),),
            //           ],
            //         ),
            //         onTap: () {
            //           Navigator.pop(context);
            //           Navigator.push(context, 
            //           MaterialPageRoute(
            //             builder: (context) => EditProfile()
            //             ),
            //           );
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          ),
    );
  }

  Widget searchBar(seController) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(width: 10,),

        Container(
          child: IconButton(
            icon: Icon(Icons.menu_rounded,),
            color: CustomColors().brownColor,
            iconSize: 28,
            onPressed: () {
              _scaffoldState.currentState!.openDrawer();
            },
          ),
        ),

        // SizedBox(width: 5,),
        Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          width: MediaQuery.of(context).size.width/1.4,
          child: TextFieldDesign.textFieldStyle(
            context: context,
            verMarg: 2,
            horMarg: 0, 
            controller: seController, 
            kbType: TextInputType.text,
            lbTxt: LocaleKeys.search_term.tr(),
            obscTxt: false,
          ),
        ),
        SizedBox(width: 5,),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width*0.08,
            height: MediaQuery.of(context).size.height*0.04,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/logo.png'),
              ),
            ),
          ),
          onTap: () {},
        ),
      ],
    ),
  );
}

  // Widget buildImg(String urlImage, int index) {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(20),
  //     child: Stack(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.symmetric(horizontal: 1),
  //           color: CustomColors().grayColor,
  //           child: Image.network(urlImage, fit: BoxFit.cover,),
  //         ),
  //         Container(
  //           margin: EdgeInsets.symmetric(horizontal: 1),
  //           decoration: BoxDecoration(
  //             color: CustomColors().blackColor,
  //             gradient: LinearGradient(
  //               begin: FractionalOffset.topCenter,
  //               end: FractionalOffset.bottomCenter,
  //               colors: [
  //                 CustomColors().blackColor.withOpacity(0.4),
  //                 CustomColors().blackColor.withOpacity(0.8),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Container(
  //           alignment: Alignment.bottomCenter,
  //           margin: EdgeInsets.only(left: 10, right: 10, bottom: 30),
  //           child: Text('Freshly Delivered To The Door \n of Your Restaurant', 
  //           style: TextStyle(
  //             color: CustomColors().primaryWhiteColor,
  //             fontWeight: FontWeight.w700,
  //           ),),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
