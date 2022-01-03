import 'package:carousel_slider/carousel_slider.dart';
import 'package:companies_alkhudra/designs/greeting_text.dart';
import 'package:companies_alkhudra/designs/search_bar.dart';
import 'package:companies_alkhudra/resources/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
    return Material(
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
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
                width: MediaQuery.of(context).size.width*0.8,
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
            ],
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
