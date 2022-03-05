// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unnecessary_string_interpolations

import 'dart:convert';

import 'package:bisita/admin_homepage.dart';
import 'package:bisita/functions.dart';
import 'package:bisita/visitor_history.dart';
import 'package:bisita/visitor_notification.dart';
import 'package:bisita/visitor_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:substring_highlight/substring_highlight.dart';

class VisitorHomePage extends StatefulWidget {
  static String id = ("VisitorHomePage");

  @override
  State<VisitorHomePage> createState() => _VisitorHomePageState();
}

class _VisitorHomePageState extends State<VisitorHomePage> {
  TextEditingController personController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  late List<String> autoCompletePersonsData;
  late List<String> autoCompleteDatesData;
  late List<String> autoCompleteEVEData;
  late List<String> autoCompleteEVSData;
  late List<String> autoCompleteAVEData;
  late List<String> autoCompleteAVSData;
  late List<String> autoCompleteFVEData;
  late List<String> autoCompleteFVSData;
  late List<String> autoCompleteGVEData;
  late List<String> autoCompleteGVSData;

  Future fetchPersonsData() async {
    final String personsStringData =
        await rootBundle.loadString("assets/persons.json");
    final List<dynamic> persons = jsonDecode(personsStringData);
    final List<String> personsData = persons.cast<String>();

    setState(
      () {
        autoCompletePersonsData = personsData;
      },
    );
  }

  Future fetchDatesData() async {
    final String datesStringData =
        await rootBundle.loadString("assets/dates.json");
    final List<dynamic> dates = jsonDecode(datesStringData);
    final List<String> datesData = dates.cast<String>();

    setState(
      () {
        autoCompleteDatesData = datesData;
      },
    );
  }

  Future fetchEvangelistaVacantEndData() async {
    final String eveStringData =
        await rootBundle.loadString("assets/evangelista_vacant_end.json");
    final List<dynamic> eve = jsonDecode(eveStringData);
    final List<String> eveData = eve.cast<String>();

    setState(
      () {
        autoCompleteEVEData = eveData;
      },
    );
  }

  Future fetchEvangelistaVacantStartData() async {
    final String evsStringData =
        await rootBundle.loadString("assets/evangelista_vacant_start.json");
    final List<dynamic> evs = jsonDecode(evsStringData);
    final List<String> evsData = evs.cast<String>();

    setState(
      () {
        autoCompleteEVSData = evsData;
      },
    );
  }

  Future fetchAcostaVacantEndData() async {
    final String aveStringData =
        await rootBundle.loadString("assets/acosta_vacant_end.json");
    final List<dynamic> ave = jsonDecode(aveStringData);
    final List<String> aveData = ave.cast<String>();

    setState(
      () {
        autoCompleteAVEData = aveData;
      },
    );
  }

  Future fetchAcostaVacantStartData() async {
    final String avsStringData =
        await rootBundle.loadString("assets/acosta_vacant_start.json");
    final List<dynamic> avs = jsonDecode(avsStringData);
    final List<String> avsData = avs.cast<String>();

    setState(
      () {
        autoCompleteAVSData = avsData;
      },
    );
  }

  Future fetchFuertesVacantEndData() async {
    final String fveStringData =
        await rootBundle.loadString("assets/fuertes_vacant_end.json");
    final List<dynamic> fve = jsonDecode(fveStringData);
    final List<String> fveData = fve.cast<String>();

    setState(
      () {
        autoCompleteFVEData = fveData;
      },
    );
  }

  Future fetchFuertesVacantStartData() async {
    final String fvsStringData =
        await rootBundle.loadString("assets/fuertes_vacant_start.json");
    final List<dynamic> fvs = jsonDecode(fvsStringData);
    final List<String> fvsData = fvs.cast<String>();

    setState(
      () {
        autoCompleteFVSData = fvsData;
      },
    );
  }

  Future fetchGulaneVacantEndData() async {
    final String gveStringData =
        await rootBundle.loadString("assets/gulane_vacant_end.json");
    final List<dynamic> gve = jsonDecode(gveStringData);
    final List<String> gveData = gve.cast<String>();

    setState(
      () {
        autoCompleteGVEData = gveData;
      },
    );
  }

  Future fetchGulaneVacantStartData() async {
    final String gvsStringData =
        await rootBundle.loadString("assets/gulane_vacant_start.json");
    final List<dynamic> gvs = jsonDecode(gvsStringData);
    final List<String> gvsData = gvs.cast<String>();

    setState(
      () {
        autoCompleteGVSData = gvsData;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchPersonsData();
    fetchEvangelistaVacantEndData();
    fetchEvangelistaVacantStartData();
    fetchAcostaVacantEndData();
    fetchAcostaVacantStartData();
    fetchFuertesVacantEndData();
    fetchFuertesVacantStartData();
    fetchGulaneVacantEndData();
    fetchGulaneVacantStartData();
    fetchDatesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.orange,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "${userData!["first"].toString()} ${userData!["middle"].toString()} ${userData!["last"].toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Need to visit PSU - Narra?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, VisitorNotificationPage.id);
                },
                icon: Icon(Icons.notifications_active,
                    color: Colors.black, size: 35),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, VisitorHistoryPage.id);
                },
                icon: Icon(Icons.history_sharp, color: Colors.black, size: 35),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, VisitorProfilePage.id);
                },
                icon: Icon(Icons.person, color: Colors.black, size: 35),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              SizedBox(height: 20),
              Text(
                "Create a new Visit Request",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  height: 1,
                  thickness: 3,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 40,
                width: 350,
                child: Autocomplete(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    } else {
                      return autoCompletePersonsData.where(
                        (element) => element.toLowerCase().contains(
                              textEditingValue.text.toLowerCase(),
                            ),
                      );
                    }
                  },
                  optionsViewBuilder:
                      (context, Function(String) onSelected, options) {
                    return Material(
                      elevation: 5,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final option = options.elementAt(index);

                          return ListTile(
                            title: SubstringHighlight(
                              text: option.toString(),
                              term: personController.text,
                              textStyleHighlight: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            onTap: () => onSelected(option.toString()),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        itemCount: options.length,
                      ),
                    );
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    personController = controller;

                    return TextField(
                      controller: personController,
                      focusNode: focusNode,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        hintText: "Concerned Person",
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 40,
                width: 350,
                child: Autocomplete(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    } else {
                      return autoCompleteDatesData.where(
                        (element) => element.toLowerCase().contains(
                              textEditingValue.text.toLowerCase(),
                            ),
                      );
                    }
                  },
                  optionsViewBuilder:
                      (context, Function(String) onSelected, options) {
                    return Material(
                      elevation: 5,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final option = options.elementAt(index);

                          return ListTile(
                            title: SubstringHighlight(
                              text: option.toString(),
                              term: dateController.text,
                              textStyleHighlight: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            onTap: () => onSelected(option.toString()),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        itemCount: options.length,
                      ),
                    );
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    dateController = controller;

                    return TextField(
                      controller: dateController,
                      keyboardType: TextInputType.number,
                      focusNode: focusNode,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        hintText: "Date",
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    child: Autocomplete(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (personController.text == "Ariel W. Evangelista") {
                          return autoCompleteEVSData.where((element) => element
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        } else if (personController.text ==
                            "Christine Joy M. Acosta") {
                          return autoCompleteAVSData.where((element) => element
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        } else if (personController.text ==
                            "Errol A. Fuertes") {
                          return autoCompleteFVSData.where((element) => element
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        } else if (personController.text ==
                            "Joel P. Gulane Jr.") {
                          return autoCompleteGVSData.where((element) => element
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        } else {
                          return const Iterable<String>.empty();
                        }
                      },
                      optionsViewBuilder:
                          (context, Function(String) onSelected, options) {
                        return Material(
                          elevation: 5,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final option = options.elementAt(index);

                              return ListTile(
                                title: SubstringHighlight(
                                  text: option.toString(),
                                  term: startController.text,
                                  textStyleHighlight: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                onTap: () => onSelected(option.toString()),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              height: 1,
                              thickness: 1,
                            ),
                            itemCount: options.length,
                          ),
                        );
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        startController = controller;

                        return TextField(
                          controller: startController,
                          keyboardType: TextInputType.text,
                          focusNode: focusNode,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            hintText: "Start Time",
                            border: OutlineInputBorder(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    child: Autocomplete(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (personController.text == "Ariel W. Evangelista") {
                          return autoCompleteEVEData.where((element) => element
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        } else if (personController.text ==
                            "Christine Joy M. Acosta") {
                          return autoCompleteAVEData.where((element) => element
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        } else if (personController.text ==
                            "Errol A. Fuertes") {
                          return autoCompleteFVEData.where((element) => element
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        } else if (personController.text ==
                            "Joel P. Gulane Jr.") {
                          return autoCompleteGVEData.where((element) => element
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        } else {
                          return const Iterable<String>.empty();
                        }
                      },
                      optionsViewBuilder:
                          (context, Function(String) onSelected, options) {
                        return Material(
                          elevation: 5,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final option = options.elementAt(index);

                              return ListTile(
                                title: SubstringHighlight(
                                  text: option.toString(),
                                  term: endController.text,
                                  textStyleHighlight: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                onTap: () => onSelected(option.toString()),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              height: 1,
                              thickness: 1,
                            ),
                            itemCount: options.length,
                          ),
                        );
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        endController = controller;

                        return TextField(
                          controller: endController,
                          keyboardType: TextInputType.text,
                          focusNode: focusNode,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            hintText: "End Time",
                            border: OutlineInputBorder(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 40,
                width: 350,
                child: TextField(
                  controller: purposeController,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    hintText: "Purpose",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: ElevatedButton(
                  onPressed: () async {
                    if (personController.text.isEmpty) {
                      functions.errorBox(
                          context, "Please enter your concerned person");
                    } else if (dateController.text.isEmpty) {
                      functions.errorBox(context, "Please enter date");
                    } else if (startController.text.isEmpty) {
                      functions.errorBox(context, "Please enter a start time");
                    } else if (endController.text.isEmpty) {
                      functions.errorBox(context, "Please enter an end time");
                    } else if (purposeController.text.isEmpty) {
                      functions.errorBox(context, "Please enter the purpose");
                    } else if (personController.text == "Joel Gulane" ||
                        personController.text == "Ariel W. Evangelista" ||
                        personController.text == "Christine Joy M. Acosta" ||
                        personController.text == "Errol A. Fuertes" ||
                        personController.text == "Joel P. Gulane Jr.") {
                      setState(() {
                        if (personController.text == "Ariel W. Evangelista") {
                          adminName = personController.text;
                          adminEmail = "aevangelista@psu.palawan.edu.ph";
                          adminPhone = "+639091965681";
                        } else if (personController.text ==
                            "Christine Joy M. Acosta") {
                          adminName = personController.text;
                          adminEmail = "cjacosta@psu.palawan.edu.ph";
                          adminPhone = "+639000000000";
                        } else if (personController.text ==
                            "Errol A. Fuertes") {
                          adminName = personController.text;
                          adminEmail = "eafuertes@psu.palawan.edu.ph";
                          adminPhone = "+639000000000";
                        } else if (personController.text ==
                            "Joel P. Gulane Jr.") {
                          adminName = personController.text;
                          adminEmail = "jgulane@psu.palawan.edu.ph";
                          adminPhone = "+639388638054";
                        }
                        functions.sendSMS(
                          "Hello $adminName! ${userData!["first"]} ${userData!["middle"]} ${userData!["last"]} requested for a visit scheduled at ${startController.text} - ${endController.text} on ${dateController.text}. Purpose: ${purposeController.text}",
                          adminPhone,
                        );
                        functions.submitRequest(
                          adminName,
                          adminEmail,
                          adminPhone,
                          dateController.text,
                          startController.text,
                          endController.text,
                          purposeController.text,
                          "Request Submitted",
                          "Pending",
                          idName,
                        );
                        setState(() {
                          vpPosition = -30;
                          vaPosition = 5000;
                          vrPosition = 5000;
                          vuPosition = 5000;
                        });
                        personController.clear();
                        dateController.clear();
                        startController.clear();
                        endController.clear();
                        purposeController.clear();
                        Navigator.pushNamed(
                            context, VisitorNotificationPage.id);
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                  ),
                  child: Text(
                    "SUBMIT REQUEST",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
