import 'dart:math' as math;

import 'package:animated_book_widget/animated_book_widget.dart';
import 'package:flutter/material.dart';

///Creating a class object
class Bray {
  final String bRayCoverImgUrl;
  final String bRayDiscImgUrl;
  final Color bRayBackgroundColor;

  Bray(
      {required this.bRayCoverImgUrl,
      required this.bRayDiscImgUrl,
      required this.bRayBackgroundColor});
}

///Simulates a background query with response a List of objects
List<Bray> bRays = [
  Bray(
    bRayCoverImgUrl:
        'https://i.ebayimg.com/images/g/e3cAAOSw2EtiXfuu/s-l1600.jpg',
    bRayDiscImgUrl: 'https://picfiles.alphacoders.com/664/66487.png',
    bRayBackgroundColor: Colors.blue.shade600,
  ),
  Bray(
    bRayCoverImgUrl:
        'https://static.thcdn.com/images/small/original/productimg/0/960/960/77/10996577-1410440223-328138.jpg',
    bRayDiscImgUrl: 'https://picfiles.alphacoders.com/975/97544.png',
    bRayBackgroundColor: Colors.blue.shade900,
  ),
  Bray(
    bRayCoverImgUrl:
        'https://rukminim2.flixcart.com/image/850/1000/k687wy80/movie/z/4/q/2020-blu-ray-paramount-pictures-excel-home-videos-english-original-imafzqtk2vuyykpd.jpeg?q=20',
    bRayDiscImgUrl:
        'https://vistapointe.net/images/beverly-hills-cop-iii-wallpaper-20.jpg',
    bRayBackgroundColor: Colors.lightBlue,
  )
];

///Widget class example
class BlueRaysExample extends StatelessWidget {
  final bool horizontalView;
  final Size widthSize = Size.fromWidth(160);
  final Size heightSize = Size.fromHeight(225);

  BlueRaysExample({
    super.key,
    required this.horizontalView,
  });

  @override
  Widget build(BuildContext context) {
    ///List of all objects
    return ListView.builder(
      ///Physics
      physics: const BouncingScrollPhysics(),

      ///Scroll axis
      scrollDirection: horizontalView ? Axis.horizontal : Axis.vertical,

      ///Number of items on the list
      itemCount: bRays.length,

      ///None clip
      clipBehavior: Clip.none,

      //Item constructor
      itemBuilder: (_, index) {
        ///For each object we return a widget constructor with the data.
        return AnimatedBookWidget.builder(
          ///Size parameter
          size: horizontalView ? widthSize : heightSize,

          ///Padding for each element of the list
          padding: EdgeInsets.symmetric(
              vertical: horizontalView ? 0 : 10,
              horizontal: horizontalView ? 10 : 0),

          ///The cover element for the book
          cover: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
              bottom: Radius.circular(10),
            ),
            child: Image.network(
              bRays[index].bRayCoverImgUrl,
              fit: BoxFit.cover,
            ),
          ),

          ///Creates the child inside the book
          contentChild: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.network(bRays[index].bRayDiscImgUrl),
          ),

          ///Customize the back content  and use the animation based on open cover animation
          contentBuilder: (context, cdAnimation, child) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: bRays[index].bRayBackgroundColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15),
                  bottom: Radius.circular(10),
                ),
              ),

              ///Animate the child
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..scale(cdAnimation.value)
                  ..rotateZ(cdAnimation.value * (2 * math.pi)),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
