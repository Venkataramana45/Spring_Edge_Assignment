import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:spring_edge_assignment/constraints/const.dart';
import 'package:spring_edge_assignment/widgets/textfield.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController commodityController = TextEditingController();
  final TextEditingController cutoffDateController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController boxCountController = TextEditingController();

  List<String> originSuggestions = [];
  List<String> destinationSuggestions = [];

  bool isOriginNearbyPortsChecked = false;
  bool isShipmentFCLChecked = false;
  bool isShipmentLCLChecked = false;
  bool isDestinationNearbyPortsChecked = false;

  @override
  void initState() {
    super.initState();
    fetchSuggestions();
  }

  Future<void> fetchSuggestions() async {
    final response = await http
        .get(Uri.parse('http://universities.hipolabs.com/search?name=middle'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      setState(() {
        originSuggestions = data.map((item) => item['name'] as String).toList();
        destinationSuggestions = originSuggestions;
      });
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6EAF8),
      appBar: AppBar(
        title: Text(
          'Search the best Freight Rates',
          style: Roboto,
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 24, top: 12, bottom: 12),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: btn_fill,
                  side: const BorderSide(color: btn),
                ),
                onPressed: () {},
                child: Text(
                  'History',
                  style: blue_16,
                ),
              )),
        ],
        backgroundColor: const Color(0xffFFFFFF),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        shadowColor: Colors.black26,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    spreadRadius: -3,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomAutoCompleteField(
                              hintText: "Origin",
                              controller: originController,
                              suggestions: originSuggestions,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Checkbox(
                                  value: isOriginNearbyPortsChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isOriginNearbyPortsChecked = value!;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  side: const BorderSide(
                                    width: 1,
                                    color: checkbox,
                                  ), // Thin grey border
                                  activeColor: blue, // Blue check color
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "Include Nearby Ports",
                                  style: gray_14,
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            TextField(
                              controller: commodityController,
                              decoration: InputDecoration(
                                hintText: "Commodity",
                                suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: arraow,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: border),
                                ),
                                hintStyle: gray_16,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              "Shipment Type:",
                              style: black_16,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Checkbox(
                                  value: isShipmentFCLChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isShipmentFCLChecked = value!;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  side: const BorderSide(
                                      width: 1, color: checkbox),
                                  activeColor: blue,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "FCL",
                                  style: black_14,
                                ),
                                const SizedBox(width: 24),
                                Checkbox(
                                  value: isShipmentLCLChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isShipmentLCLChecked = value!;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  side: const BorderSide(
                                      width: 1, color: checkbox),
                                  activeColor: blue,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "LCL",
                                  style: black_14,
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            TextField(
                              controller:
                                  TextEditingController(text: "40’ Standard"),
                              style: gray_16,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: border),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                labelText: "Container Size",
                                labelStyle: gray_12,
                                suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: arraow,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomAutoCompleteField(
                              hintText: "Destination",
                              controller: destinationController,
                              suggestions: destinationSuggestions,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Checkbox(
                                  value: isDestinationNearbyPortsChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isDestinationNearbyPortsChecked = value!;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  side: const BorderSide(
                                    width: 1,
                                    color: checkbox,
                                  ),
                                  activeColor: blue,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text("Include Nearby Ports", style: gray_14),
                              ],
                            ),
                            const SizedBox(height: 24),
                            TextField(
                              controller: cutoffDateController,
                              decoration: InputDecoration(
                                hintText: "Cutoff Date",
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: border),
                                ),
                                hintStyle: gray_16,
                                suffixIcon: Image.asset(
                                  'assets/calendar.png',
                                ),
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  cutoffDateController.text =
                                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                }
                              },
                            ),
                            const SizedBox(height: 125),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: boxCountController,
                                    decoration: InputDecoration(
                                      hintText: "No of Boxes",
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide:
                                              BorderSide(color: border)),
                                      hintStyle: gray_16,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: TextField(
                                    controller: weightController,
                                    decoration: InputDecoration(
                                      hintText: "Weight (Kg)",
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide:
                                              BorderSide(color: border)),
                                      hintStyle: gray_16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Image.asset(
                        'assets/info.png',
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        " To obtain accurate rate for spot rate with guaranteed space and booking, please ensure your container count and weight per container is accurate",
                        style: gray_14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Container Internal Dimension :",
                    style: black_16,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Length: ", style: gray_14),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(" 39.46 ft", style: black_14),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Text("Width: ", style: gray_14),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(" 7.70 ft", style: black_14),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Text("Height: ", style: gray_14),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(" 7.84 ft", style: black_14),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 48),
                      Image.asset('assets/container.png', scale: 2),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: btn_fill,
                          side: const BorderSide(
                            color: btn,
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.search, color: btn),
                            Text(
                              'Search',
                              style: blue_16,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
