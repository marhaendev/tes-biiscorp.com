import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'api.dart';

class TablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Table')),
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
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(color: Colors.blue, width: 5)),
                    ),
                    child: Text(
                      "Data diambil dari \n${Get.find<GetApi>().urlUsers}${GetApi.page}",
                      style: GoogleFonts.firaCode(),
                    ),
                  ),
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
                          height:
                              Get.height * 0.5, // Atur tinggi sesuai kebutuhan
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
                          onPressed: () => Get.find<GetApi>()
                              .back(), // Memanggil method back dari GetApi
                          child: Row(
                            children: [Icon(Icons.arrow_left), Text("Back")],
                          )),
                      SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: () => Get.find<GetApi>()
                              .next(), // Memanggil method next dari GetApi
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
