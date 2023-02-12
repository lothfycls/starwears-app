import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/bloc/banner_bloc.dart';
import 'package:starwears/bloc/newlistings_bloc.dart';

class HomeCarousel extends StatefulWidget {
  @override
  _HomeCarouselState createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewlistingsBloc, NewlistingsState>(
        builder: (context, state) {
      print(state);
      if (state is ListingsReady) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Stack(
            children: [
              Container(
                height: 300,
                // color: Color.fromARGB(107, 255, 255, 255),
                child: CarouselSlider(
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      enableInfiniteScroll: true,
                      initialPage: 0,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                    items: List.generate(
                        state.listings.length > 3 ? 3 : state.listings.length,
                        (index) {
                      return ShaderMask(
                        blendMode: BlendMode.srcOver,
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              Color.fromARGB(150, 255, 255, 255),
                              Color.fromARGB(106, 255, 255, 255)
                            ],
                            stops: [0.0, 1.0],
                          ).createShader(bounds);
                        },
                        child: Image.network(
                          state.listings[index].image,
                          fit: BoxFit.cover,
                          height: 300,
                        ),
                      );
                    })),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 50,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Color(0xffBEBEBE)),
                        alignLabelWithHint: true,
                        hintText: 'Search',
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color(0xffBEBEBE),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(height: 300,color: Color.fromARGB(102, 255, 255, 255),),
              Positioned(
                bottom: -20,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New listings",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 200,
                        height: 30,
                        child: Text(
                          state.listings[_currentIndex].description,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 13, overflow: TextOverflow.clip),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                // left: 0,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? Color(0xFFB22222)
                            : Colors.black,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      } else {
        return const Center(
          child: Text("No new listings yet"),
        );
      }
    });
  }
}
