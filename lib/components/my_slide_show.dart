import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ata_app/config/api_config.dart';
import 'package:ata_app/models/slide.dart';

class MySlideShow extends StatefulWidget {
  final Future<List<Slide>> futureSlides;

  MySlideShow({super.key, required this.futureSlides});
  @override
  _MySlideShowScreenState createState() => _MySlideShowScreenState();
}

class _MySlideShowScreenState extends State<MySlideShow> {
  
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Slide>>(
      future:  widget.futureSlides,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return Center(child: Text('No slides available.'));
        }

        final slides = snapshot.data!;
        return Stack(
          children: [
            _buildCarousel(slides),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: _buildPageIndicators(slides),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCarousel(List<Slide> slides) {
    return CarouselSlider(
      carouselController: _carouselController,
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1.0,
        autoPlayInterval: Duration(seconds: 5),
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      items: slides.map((slide) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              // margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  '${ApiConfig.baseImageUrl}slides/${slide.image}',
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildPageIndicators(List<Slide> slides) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: slides.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _carouselController.animateToPage(entry.key),
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  _currentIndex == entry.key ? Colors.blueAccent : Colors.grey,
            ),
          ),
        );
      }).toList(),
    );
  }
}
