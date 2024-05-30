import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tes/api.dart';
import 'package:tes/constant.dart';

class LoginController extends GetxController {}

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  final GetApi api = Get.find<GetApi>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Login"),
      body: SingleChildScrollView(
        child: GetBuilder<GetApi>(
          builder: (apiController) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                blockquote("post ke \n${api.el}", blue, 5),
                boxY(10),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: edge(10),
                  padding: edge(0, 10),
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: teal, width: 5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "username: ${api.loginUser}",
                        style: GoogleFonts.firaCode(),
                      ),
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: api.loginUser.toString()));
                            Get.snackbar(
                                'Copied', 'Username copied to clipboard');
                          },
                          icon: Icon(Icons.copy))
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: edge(10),
                  padding: edge(0, 10),
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: teal, width: 5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "password: ${api.loginPass}",
                        style: GoogleFonts.firaCode(),
                      ),
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: api.loginPass.toString()));
                            Get.snackbar(
                                'Copied', 'Password copied to clipboard');
                          },
                          icon: Icon(Icons.copy))
                    ],
                  ),
                ),
                boxY(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(shape: radius(0)),
                      onPressed: () {
                        emailController.text = api.loginUser.value;
                        passwordController.text = api.loginPass.value;
                      },
                      label: Text("isi otomatis"),
                      icon: Icon(Icons.auto_awesome),
                    ),
                    boxX(10),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(shape: radius(0)),
                      onPressed: () {
                        emailController.text = "";
                        passwordController.text = "";
                      },
                      label: Text("clear"),
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
                boxY(10),
                Center(
                  child: Padding(
                    padding: edge(30.0),
                    child: Card(
                      child: Padding(
                        padding: edge(10.0),
                        child: Column(
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(labelText: 'Email'),
                            ),
                            boxY(10),
                            Obx(() {
                              return TextFormField(
                                obscureText: api.isSecure.value,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      api.isSecure.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      api.isSecure.toggle();
                                    },
                                  ),
                                ),
                              );
                            }),
                            boxY(20),
                            Obx(() {
                              return api.isLoading.value
                                  ? CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: () {
                                        final email = emailController.text;
                                        final password =
                                            passwordController.text;
                                        api.login(email, password);
                                        apiController.reset();
                                      },
                                      child: Text('Login'),
                                    );
                            }),
                            boxY(10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
