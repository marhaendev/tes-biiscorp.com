import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constant.dart';
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
        primarySwatch: blue,
        textTheme: GoogleFonts.robotoSlabTextTheme(),
      ),
      home: Scaffold(
        appBar: appbar("Home"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              blockquote(
                  "created by\nnama: Hasan Askari\nemail: hasanaskari.id@gmail.com",
                  black,
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
        shape: radius(0), backgroundColor: teal, foregroundColor: white),
    onPressed: () {
      Get.to(e);
      api.reset();
    },
    child: Text(text),
  );
}
