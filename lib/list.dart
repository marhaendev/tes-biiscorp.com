import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tes/constant.dart';
import 'api.dart';

class ListPage extends StatelessWidget {
  final GetApi api = Get.find<GetApi>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Data List'),
      body: GetBuilder<GetApi>(
        builder: (apiController) {
          return FutureBuilder<List<dynamic>>(
            future: api.fetchUsers(),
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
                      "Data diambil dari \n${api.urlUsers}${GetApi.page}",
                      blue,
                      3),
                  Theme(
                    data: ThemeData().copyWith(dividerColor: transparent),
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
                                  jsonBeauty(snapshot.data),
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
                  if (int.parse(GetApi.page.value) < 3)
                    Expanded(
                      child: ListView(
                        children: snapshot.data!.map<Widget>((data) {
                          return Card(
                            shape: radius(50),
                            margin: edge(10, 15),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage("${data['avatar']}"),
                              ),
                              title: Text(
                                  '${data['first_name']} ${data['last_name']}'),
                              subtitle: Text(data['email']),
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
