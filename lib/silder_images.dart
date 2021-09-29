import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderImages extends StatefulWidget {
  @override
  _SliderImageState createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImages> {
  final urlImages = [
    'https://saudiscoop.com/wp-content/uploads/2021/04/file-13-1444638977703848900.jpg',
    'https://media.gettyimages.com/photos/al-masmak-fortress-at-dusk-saudi-flag-on-almasmak-plaza-riyadh-saudi-picture-id1183235673?s=2048x2048',
    'https://media.gettyimages.com/photos/saudi-arabia-riyadh-the-masmak-fortress-in-the-old-city-center-at-picture-id629535965?s=2048x2048',
    'https://www.visitsaudi.com/content/dam/saudi-tourism/media/highlights/a031/brand-page-hero.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2d/%D8%A7%D9%84%D9%85%D8%B5%D9%85%D9%83.jpg/1280px-%D8%A7%D9%84%D9%85%D8%B5%D9%85%D9%83.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Masmak_Castle_from_Thumairi.jpg/1280px-Masmak_Castle_from_Thumairi.jpg',
    'https://ccute.cc/wp-content/uploads/2019/04/11463.jpeg',
  ];

  List<Widget> buildImage() {
    return urlImages
        .map(
          (element) => ClipRRect(
            child: Image.network(
              element,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // color: Colors.white,
      // padding: const EdgeInsets.only(top: 25),
      // appBar: AppBar(
      //   title: Text('Al-Masmak Fortress'),
      //   centerTitle: true,
      // ),
      child: Stack(
        children: [
          CarouselSlider(
            items: buildImage(),
            options: CarouselOptions(
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              autoPlay: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              autoPlayInterval: Duration(
                seconds: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
