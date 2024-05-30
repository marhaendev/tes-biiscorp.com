import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tes/constant.dart';
import 'api.dart';
import 'list.dart';
import 'table.dart';
import 'login.dart';

void main() {
  Get.put(GetApi());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tes Skill',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoSlabTextTheme(),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _createLabel(
                  "created by\nnama: Hasan Askari\nemail: hasanaskari.id@gmail.com",
                  Colors.black,
                  3),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _CreateElevatedButton(ListPage(), 'Go to Data List'),
                    boxY(10),
                    _CreateElevatedButton(TablePage(), 'Go to Data Table'),
                    boxY(10),
                    _CreateElevatedButton(LoginPage(), 'Go to Data Login'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _CreateElevatedButton(e, text) {
  final GetApi api = Get.find<GetApi>();
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: radius(0),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white),
    onPressed: () {
      Get.to(e);
      api.reset();
      // api.isSecure.value = true;
    },
    child: Text(text),
  );
}

Widget _createLabel(e, color, double width) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.all(10),
    padding: padding(0, 10),
    decoration: BoxDecoration(
      border: Border(left: BorderSide(color: color, width: width)),
    ),
    child: Text(
      e,
      style: GoogleFonts.firaCode(),
    ),
  );
}
