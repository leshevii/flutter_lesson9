import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson_9/models/hotel.dart';
import 'package:flutter_lesson_9/models/info.dart';
import 'package:http/http.dart';

const String info = 'https://run.mocky.io/v3/';

class InfoView extends StatelessWidget {
  HotelPreview hotel;
  InfoView({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
      ),
      body: FutureBuilder(
        future: get(Uri.parse('${info}${hotel.uuid}')),
        builder: (context, snap) {
          if (snap.hasError)
            return Center(
              child: Text('Произошла ощибка'),
            );
          if (snap.hasData) {
            if ((snap.data as Response).statusCode == 404)
              return Center(
                child: Text('Content is not found'),
              );
            var info = Info.fromJson(jsonDecode((snap.data as Response).body));
            List titles = [
              {'title': 'Страна: ', 'value': info.address.country},
              {'title': 'Город: ', 'value': info.address.city},
              {'title': 'Улица: ', 'value': info.address.street},
              {'title': 'Рейтинг: ', 'value': info.rating},
            ];
            return Column(
              children: [
                Slider(photos: info.photos),
                for (var el in titles)
                  titleRow(el['title'], el['value'].toString()),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Сервисы',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    services('Платные', info.services['paid'] as List),
                    SizedBox(width: 5),
                    services('Бесплатные', info.services['free'] as List),
                  ],
                )
              ],
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget services(String title, List services) {
    return Container(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          SizedBox(height: 10),
          for (var el in services) Text(el)
        ],
      ),
    );
  }

  Widget titleRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class Slider extends StatelessWidget {
  List<String> photos;
  Slider({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: photos
          .map((e) => Container(
                width: 400,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Image.asset(
                  'assets/images/$e',
                  fit: BoxFit.fitWidth,
                ),
              ))
          .toList(),
      options: CarouselOptions(height: 200.0, viewportFraction: 0.9),
    );
  }
}
