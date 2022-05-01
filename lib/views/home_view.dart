import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_lesson_9/models/hotel.dart';
import 'package:flutter_lesson_9/widgets/card_hotel.dart';
import 'package:http/http.dart' as http;

const url = 'https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isList = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _isList = true;
                });
              },
              icon: Icon(Icons.menu)),
          IconButton(
              onPressed: () {
                setState(() {
                  _isList = false;
                });
              },
              icon: Icon(Icons.app_registration_sharp)),
        ],
      ),
      body: FutureBuilder(
        future: http.get(Uri.parse(url)),
        builder: (contetxt, snap) {
          if (snap.hasData) {
            List<dynamic> l = jsonDecode((snap.data as http.Response).body);
            List<HotelPreview> hotels =
                l.map((e) => HotelPreview.fromJson(e)).toList();

            if (_isList)
              return ListView.builder(
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  return CardHotel(
                    hotelPreview: hotels[index],
                    isList: true,
                  );
                },
              );

            return GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
              ),
              children: [
                for (var hotel in hotels)
                  CardHotel(
                    hotelPreview: hotel,
                    isList: false,
                  ),
              ],
            );
          }
          if (snap.hasError) {
            return Center(
              child: Text('Не удалось загрузить список отелей'),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
