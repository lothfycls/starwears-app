import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/bloc/newlistings_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeCarou extends StatefulWidget {
  final bool showCarousel;
  HomeCarou({required this.showCarousel});
  @override
  _HomeCarouState createState() => _HomeCarouState();
}

class _HomeCarouState extends State<HomeCarou> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: Colors.white,
        collapsedHeight: 60,
        toolbarHeight: 60,
        elevation: 0.0,
        pinned: true,
        title: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 45,
          decoration: const BoxDecoration(
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
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Color(0xFFBEBEBE)),
                alignLabelWithHint: true,
                hintText: 'Search',
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        expandedHeight: 350,
        flexibleSpace: FlexibleSpaceBar(
          background: BlocBuilder<NewlistingsBloc, NewlistingsState>(
              builder: (context, state) {
            if (state is ListingsReady) {
              return Container(
                height: 350,
                margin: const EdgeInsets.only(bottom: 20),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      child: SizedBox(
                        height: 500,
                        width: MediaQuery.of(context).size.width,
                        child: CarouselSlider(
                            options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                              enableInfiniteScroll: true,
                              initialPage: 0,
                              aspectRatio: 0.5,
                              viewportFraction: 1,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 2),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                            ),
                            items: List.generate(
                                state.listings.length > 3
                                    ? 3
                                    : state.listings.length, (index) {
                              return ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return const LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [Colors.transparent, Colors.black],
                                  ).createShader(Rect.fromLTRB(
                                      0, 0, bounds.width, bounds.height));
                                },
                                blendMode: BlendMode.dstIn,
                                child: Stack(
                                  children: <Widget>[
                                    const Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.black,
                                    )),
                                    Center(
                                      child: FadeInImage.memoryNetwork(
                                        fit: BoxFit.cover,
                                        height: 300,
                                        placeholder: kTransparentImage,
                                        image: state.listings[index].image,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })),
                      ),
                    ),
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
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
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
          }),
        ));
  }
}
