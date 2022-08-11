import 'package:advocate/screens/pendingCases.dart';
import 'package:advocate/tools/calender.dart';
import 'package:advocate/widgets/Drawer_HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var UserName;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Image(
            image: NetworkImage(
                "https://previews.123rf.com/images/3xy/3xy2001/3xy200100002/139226140-lady-justice-themis-with-sword-and-scales-fair-trial-law-femida-blindfolded-lady-logo-or-label-for-l.jpg",
                scale: 20),
          ),
        ),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      drawer: const HomePageDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent.shade100,
                    ),
                    height: height * 0.25 >= 180 ? height * 0.25 : 180,
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Image(
                            image: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/512/1090/1090965.png",
                                scale: 5),
                          ),
                          FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PendingCases()));
                            },
                            elevation: 5,
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: const Icon(Icons.arrow_circle_right),
                            label: const Text("Pending Cases"),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow.shade200,
                    ),
                    height: height * 0.25 >= 180 ? height * 0.25 : 180,
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Image(
                            image: NetworkImage(
                                "https://icons.iconarchive.com/icons/fps.hu/free-christmas-flat-circle/512/calendar-icon.png",
                                scale: 5),
                          ),
                          FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Calendar()));
                            },
                            elevation: 5,
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: const Icon(Icons.arrow_circle_right),
                            label: const Text("Calender"),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 8),
              child: SizedBox(
                  height: 30,
                  child: Text(
                    "welcome ${FirebaseAuth.instance.currentUser!.email == null ? FirebaseAuth.instance.currentUser!.phoneNumber : FirebaseAuth.instance.currentUser!.email ?? ''} :(",
                    textScaleFactor: 1.5,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
