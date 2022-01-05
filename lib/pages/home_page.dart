import 'package:carousel_slider/carousel_slider.dart';
import 'package:companies_alkhudra/Constant/locale_keys.dart';
import 'package:companies_alkhudra/designs/greeting_text.dart';
import 'package:companies_alkhudra/designs/product_card.dart';
import 'package:companies_alkhudra/designs/search_bar.dart';
import 'package:companies_alkhudra/dialogs/two_btns_dialog.dart';
import 'package:companies_alkhudra/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'add_branches_page.dart';


class HomePage extends StatefulWidget {
  final bool isHasBranch;
  const HomePage({Key? key, required this.isHasBranch}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

  final imgList = [
    'https://images.unsplash.com/photo-1575218823251-f9d243b6f720?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8dmVnZXRhYmxlc3xlbnwwfDB8MHx8&auto=format&fit=crop&w=700&q=60',
    'https://images.unsplash.com/photo-1562347810-18a0d370ba36?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fGZydWl0c3xlbnwwfDB8MHx8&auto=format&fit=crop&w=700&q=60',
    'https://images.unsplash.com/photo-1522184216316-3c25379f9760?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHZlZ2V0YWJsZXN8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=700&q=60',
    'https://images.unsplash.com/photo-1563699498778-aa8246fa5456?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzN8fHZlZ2V0YWJsZXN8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=700&q=60',
    'https://images.unsplash.com/photo-1583507171283-0d663f8416c8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fHZlZ2V0YWJsZXxlbnwwfDB8MHx8&auto=format&fit=crop&w=700&q=60',
    'https://images.unsplash.com/photo-1562051725-cc35a65c8227?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mzl8fGZydWl0c3xlbnwwfDB8MHx8&auto=format&fit=crop&w=700&q=60',
  ];

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width; 
    double scHeight = size.height;

    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            // height: MediaQuery.of(context).size.height,
            color: CustomColors().backgroundColor,
            child: Column(
              children: [
                //greeting user
                Container( 
                  child: greeting(context),
                ),
                SizedBox(height: 10,),
                //row of: menu bar + search bar + search button
                Container(
                  child: searchBar(context, searchController),
                ),
                SizedBox(height: 20,),
                //image slideshow
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    //Image slideshow
                    //could replace images with different urls in imgList
                    child: Stack(
                      children: [
                        CarouselSlider.builder(
                          //number of images
                          itemCount: imgList.length, 
                          itemBuilder: (context, index, realIndex) {
                            final urlImage = imgList[index];
                            return buildImg(urlImage, index);
                          }, 
                          options: CarouselOptions(
                            // pageSnapping: false,
                            // enableInfiniteScroll: false,
                            height: 200,
                            autoPlay: true,
                            // enlargeCenterPage: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,), 
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
                productCard(context, 0, 'Avocado'),
                Divider(
                  thickness: 5,
                  color: CustomColors().grayColor,
                ),
                productCard(context, 0, 'Melons'),
                Divider(
                  thickness: 5,
                  color: CustomColors().grayColor,
                ),
                productCard(context, 0, 'Carrots'),
                Divider(
                  thickness: 5,
                  color: CustomColors().grayColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImg(String urlImage, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 1),
            color: CustomColors().grayColor,
            child: Image.network(urlImage, fit: BoxFit.cover,),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: CustomColors().blackColor,
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  CustomColors().blackColor.withOpacity(0.4),
                  CustomColors().blackColor.withOpacity(0.8),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 30),
            child: Text('Freshly Delivered To The Door \n of Your Restaurant', 
            style: TextStyle(
              color: CustomColors().primaryWhiteColor,
              fontWeight: FontWeight.w700,
            ),),
          ),
        ],
      ),
    );
  }
}
