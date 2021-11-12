import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location ;
  String time ;
  String flag ;
  String url ;
  bool isDaytime;

  WorldTime({this.location="",this.flag = "",this.url = "",this.time="",this.isDaytime=false});

  Future<void> getTime() async {

    try {
      http.Response response =  await  http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
//    print(data);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].toString().substring(1,3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours:int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }catch(e)
    {
      print('caught error  - $e');
      time = "could not get time";
    }
  }


}