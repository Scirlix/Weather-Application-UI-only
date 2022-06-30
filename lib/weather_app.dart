import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:weather_app/models/weather_location.dart';
import 'package:weather_app/widgets/buildin_transform.dart';
import 'package:weather_app/widgets/slider.dart';
import 'package:weather_app/widgets/weather_widget.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentPage = 0;
  String bgImg = "";

  _onPageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locationList[_currentPage].weatherType == "Sunny") {
      bgImg = "assets/sunny.jpg";
    } else if (locationList[_currentPage].weatherType == "Night") {
      bgImg = "assets/night.jpg";
    } else if (locationList[_currentPage].weatherType == "Rainy") {
      bgImg = "assets/rainy.jpg";
    } else if (locationList[_currentPage].weatherType == "Cloudy") {
      bgImg = "assets/cloudy.jpeg";
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () => print("hi"),
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            bgImg,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.black38),
          ),
          Container(
            margin: EdgeInsets.only(top: 110, left: 15),
            child: Row(
              children: [
                for (int i = 0; i < locationList.length; i++)
                  if (i == _currentPage) SliderDot(true) else SliderDot(false)
              ],
            ),
          ),
          TransformerPageView(
              transformer: ScaleAndFadeTransformer(),
              viewportFraction: 0.8,
              scrollDirection: Axis.horizontal,
              onPageChanged: _onPageChange,
              itemCount: locationList.length,
              itemBuilder: (ctx, i) => WeatherWidget(
                    index: i,
                  )),
        ],
      ),
    );
  }
}
