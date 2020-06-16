import 'package:auto_center/Pages/scrclient.dart';
import 'package:auto_center/Pages/test/SearchC.dart';
import 'package:auto_center/Pages/test/searchclient.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_center/Pages/flutter_calendar_carousel.dart';
import 'Auto_parts.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<BottomNavigationPage> {
  @override

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        searchclient(),
//        Auto_parts(),
        CalendarCarousel(),
      ].elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(title: Text("Client") , icon:Icon(Icons.home)),
//          BottomNavigationBarItem(title: Text("Auto-Parts") , icon:Icon(FontAwesomeIcons.carAlt)),
          BottomNavigationBarItem(title: Text("Calendar") , icon:Icon(Icons.calendar_today)),

        ],
        onTap: _onBarItemTap,
        currentIndex: _selectedIndex,
      ),
    );
  }

  void _onBarItemTap(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}

