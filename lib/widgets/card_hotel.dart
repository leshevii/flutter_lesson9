import 'package:flutter/material.dart';
import 'package:flutter_lesson_9/models/hotel.dart';
import 'package:flutter_lesson_9/views/info_view.dart';

class CardHotel extends StatelessWidget {
  HotelPreview hotelPreview;
  bool isList;
  CardHotel({Key? key, required this.hotelPreview, required this.isList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = isList ? 200 : 80;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: isList ? 15 : 5),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 3,
              offset: Offset(2, 1),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Expanded(
                flex: isList ? 2 : 1,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/${hotelPreview.poster}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: isList
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(hotelPreview.name),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          InfoView(hotel: hotelPreview),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Подробнее',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                ),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(hotelPreview.name),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.blue,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Подробнее',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
