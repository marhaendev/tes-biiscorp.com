import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tes/api.dart';
import 'package:tes/constant.dart';

class DataLoginPage extends StatelessWidget {
  final GetApi api = Get.find<GetApi>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Login')),
      body: GetBuilder<GetApi>(
        builder: (apiController) {
          return FutureBuilder<List<dynamic>>(
            future: api.fetchDataLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              else if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  blockquote(
                      "Data diambil dari \n${api.urlDataLogin}${GetApi.page}",
                      blue,
                      5),
                  Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        "response:",
                        style: GoogleFonts.firaCode(),
                      ),
                      childrenPadding: noEdge,
                      children: [
                        SizedBox(
                          height: Get.height * 0.5,
                          child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleChildScrollView(
                                child: Text(
                                  JsonEncoder.withIndent('  ')
                                      .convert(snapshot.data),
                                  style: GoogleFonts.robotoMono(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => apiController.back(),
                          child: Row(
                            children: [Icon(Icons.arrow_left), Text("Back")],
                          )),
                      boxX(20),
                      ElevatedButton(
                          onPressed: () => apiController.next(),
                          child: Row(
                            children: [Text("Next"), Icon(Icons.arrow_right)],
                          )),
                    ],
                  ),
                  if (snapshot.data!.isEmpty)
                    Expanded(child: Center(child: Text("Tidak Ada Response"))),
                  Expanded(
                    child: ListView(
                      children: snapshot.data!.map<Widget>((data) {
                        return Card(
                          shape: radius(4),
                          margin: edge(10, 15),
                          child: ListTile(
                            leading: Text(
                              "${data['id']}",
                              style: TextStyle(
                                  color: Color(colorHex(data['color']))),
                            ),
                            title: Text('${data['name']}'),
                            subtitle: Text(
                              data['year'].toString(),
                              style: TextStyle(color: grey),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
