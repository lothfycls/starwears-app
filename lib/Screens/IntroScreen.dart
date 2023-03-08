import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:starwears/Screens/HomeScreen.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentIndex = 0;

  final List<String> videos = [
    "assets/videos/1.m4v",
    "assets/videos/2.m4v",
    "assets/videos/3.m4v",
    "assets/videos/4.m4v"
  ];
  final List<String> _texts = [
    'Welcome to Stars Clothes Auction! Bid on the latest fashion trends and get a chance to win them at unbeatable prices. Sign up now to start bidding.',
    'Browse our collection of designer clothes, set your bid amount and wait for the auction to end. The highest bidder wins the product at the end of the auction period.',
    'Keep an eye on the bidding history and choose the right moment to place your bid. Set a maximum bid amount and let the app do the work for you.',
    'If you win an auction, the app will notify you and guide you through the payment process. Once payment is confirmed, your product will be delivered to your doorstep in no time.'
  ];
  late ChewieController chewieController;
  @override
  void dispose() {
    super.dispose();
    chewieController.dispose();
  }

  @override
  void initState() {
    super.initState();
    chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.asset(videos[_currentIndex]),
      looping: true,
      autoPlay: true,
      showControls: false,
      showOptions: false,
      showControlsOnInitialize: false,
      autoInitialize: true,
      allowFullScreen: true,
    );

    chewieController.setVolume(0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 500,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
               SizedBox(
                  height: 500,
                  child: PageView.builder(
                    itemCount: videos.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                        chewieController = ChewieController(
                          videoPlayerController: VideoPlayerController.asset(
                              videos[_currentIndex]),
                          looping: true,
                          autoPlay: true,
                          showControls: false,
                          showOptions: false,
                          showControlsOnInitialize: false,
                          autoInitialize: true,
                          allowFullScreen: true,
                        );

                        chewieController.setVolume(0.0);
                      });
                    },
                    itemBuilder: (context, index) {
                      return SizedBox(
                          height: 500,
                          child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [Colors.transparent, Colors.black],
                                ).createShader(Rect.fromLTRB(
                                    0, 0, bounds.width, bounds.height));
                              },
                              blendMode: BlendMode.dstIn,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: _currentIndex == 0
                                      ? Radius.circular(100)
                                      : Radius.circular(0),
                                  bottomRight: _currentIndex == 3
                                      ? Radius.circular(100)
                                      : Radius.circular(0),

                                  // topRight: Radius.circular(100),
                                ),
                                child: Chewie(
                                  controller: chewieController,
                                ),
                              )));
                    },
                  ),
                ),
              
              Positioned(
                  top: 40,
                  left: 0,
                  right: 0,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.transparent, Colors.black],
                      ).createShader(
                          Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 50,
                    ),
                  )),
            ]),
          ),
          SizedBox(
            height: 50,
            child: Center(
              child: DotsIndicator(
                dotsCount: videos.length,
                position: _currentIndex.toDouble(),
                decorator: DotsDecorator(
                  activeColor: Colors.black,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                _texts[_currentIndex],
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Colors.black,
              textColor: Colors.white,
              child: Text(_currentIndex == 3 ? 'Finish' : 'Next'),
              onPressed: () {
                if (_currentIndex == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                } else {
                  setState(() {
                    _currentIndex = (_currentIndex + 1) % videos.length;
                    chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.asset(videos[_currentIndex]),
      looping: true,
      autoPlay: true,
      showControls: false,
      showOptions: false,
      showControlsOnInitialize: false,
      autoInitialize: true,
      allowFullScreen: true,
    );

    chewieController.setVolume(0.0);
                  });
                }
                // Handle the button press
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
