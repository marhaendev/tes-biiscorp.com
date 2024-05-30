import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tes/constant.dart';
import 'api.dart';

class TablePage extends StatelessWidget {
  final GetApi api = Get.find<GetApi>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Data Table'),
      body: GetBuilder<GetApi>(
        builder: (apiController) {
          return FutureBuilder<List<dynamic>>(
            future: Get.find<GetApi>().fetchUsers(),
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
                      "Data diambil dari \n${Get.find<GetApi>().urlUsers}${GetApi.page}",
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
                      childrenPadding: EdgeInsets.zero,
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
                  if (snapshot.data != null && snapshot.data!.isEmpty)
                    Expanded(child: Center(child: Text("Tidak Ada Response"))),
                  if (snapshot.data != null && snapshot.data!.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Email')),
                          ],
                          rows: snapshot.data!.map<DataRow>((data) {
                            return DataRow(
                              cells: [
                                DataCell(Text('${data['id']}')),
                                DataCell(Text(
                                    '${data['first_name']} ${data['last_name']}')),
                                DataCell(Text('${data['email']}')),
                              ],
                            );
                          }).toList(),
                        ),
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
