import 'package:advocate/models/pendingCasesModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingCases extends StatefulWidget {
  const PendingCases({Key? key}) : super(key: key);

  @override
  State<PendingCases> createState() => _PendingCasesState();
}

class _PendingCasesState extends State<PendingCases> {
  List<PendingCasesmodel> casespending = [];
  List<String> collectionpath = ['pending_cases'];
  var isloaded = false;
  @override
  void initState() {
    fetchdata();
    FirebaseFirestore.instance
        .collection('pending_cases')
        .snapshots()
        .listen((record) {
      mapRecords(record);
    });
    super.initState();
  }

  fetchdata() async {
    var records =
        await FirebaseFirestore.instance.collection('pending_cases').get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _recv = records.docs
        .map(
          (e) => PendingCasesmodel(
              id: e.id, day: e['day'], name: e['name'], date: e['date']),
        )
        .toList();

    setState(() {
      casespending = _recv;
      if (records.docs.length != null) {
        isloaded = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(CupertinoIcons.return_icon),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showAddDialog();
                },
                icon: const Icon(Icons.add_box_outlined))
          ]),
      body: Visibility(
        visible: isloaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey("$index"),
              background: Container(
                color: const Color(0xFFFFCCCB),
                child: const Padding(
                  padding: EdgeInsets.only(left: 12, top: 25),
                  child: Text(
                    "Delete",
                    textAlign: TextAlign.left,
                    textScaleFactor: 1.5,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              secondaryBackground: Container(
                color: const Color(0xFFe6ffe6),
                child: const Padding(
                  padding: EdgeInsets.only(right: 12, top: 25),
                  child: Text(
                    "Update",
                    textAlign: TextAlign.right,
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Case Deleted Sucessfully"),
                    duration: Duration(seconds: 2),
                    backgroundColor: Color(0xFFFFCCCB),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Case Updated Sucessfully"),
                    duration: Duration(seconds: 2),
                    backgroundColor: Color(0xFFe6ffe6),
                  ));
                }
              },
              confirmDismiss: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Delete"),
                      content: const Text("Are you sure want to delete?"),
                      actions: <Widget>[
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              deletecase(casespending[index].id);
                            },
                            child: const Text("Yes")),
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("No")),
                      ],
                    ),
                  );
                } else {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Update"),
                      content: const Text("Are you sure want to Update?"),
                      actions: <Widget>[
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text("Yes")),
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("No")),
                      ],
                    ),
                  );
                }
              },
              child: Card(
                elevation: 5,

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                // color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                color: Colors.grey,
                child: ListTile(
                  title: Text(
                    casespending[index].name,
                    textScaleFactor: 1.5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("This is discription."),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${casespending[index].day.substring(0, 3).toUpperCase()} ",
                              textScaleFactor: 1.25,
                              style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Icons.date_range,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          casespending[index].date!,
                          textScaleFactor: 1.25,
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: casespending.isEmpty ? 5 : casespending.length,
        ),
      ),
    );
  }

  Future showAddDialog() {
    var namecontroller = TextEditingController();
    var datecontroller = TextEditingController();
    var daycontroller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1)),
                      child: const Text(
                        "Add Case",
                        textAlign: TextAlign.center,
                        textScaleFactor: 2,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: namecontroller,
                      decoration: const InputDecoration(
                          hintText: "Enter the name of case",
                          label: Text("Name")),
                    ),
                    TextField(
                      controller: datecontroller,
                      decoration: const InputDecoration(
                          hintText: "Enter the Date", label: Text("Date")),
                    ),
                    TextField(
                      controller: daycontroller,
                      decoration: const InputDecoration(
                          hintText: "Enter the Day", label: Text("Day")),
                    ),
                    TextButton(
                        onPressed: () {
                          var _name = namecontroller.text.trim();
                          var _date = datecontroller.text.trim();
                          var _day = daycontroller.text.trim();
                          addCase(_name, _date, _day);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'))
                  ],
                ),
              ),
            ));
  }

  addCase(String name, String date, String day) {
    var _cases = PendingCasesmodel(id: 'id', day: day, name: name, date: date);
    FirebaseFirestore.instance.collection('pending_cases').add(_cases.toJson());
  }

  deletecase(var id) {
    FirebaseFirestore.instance.collection('pending_cases').doc(id).delete();
  }
}
