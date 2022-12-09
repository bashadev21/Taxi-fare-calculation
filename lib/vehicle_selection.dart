import 'package:flutter/material.dart';
import 'package:taziapp/constants.dart';

import 'distance_entry.dart';

class VehiclSelectioView extends StatefulWidget {
  const VehiclSelectioView({super.key});

  @override
  State<VehiclSelectioView> createState() => _VehiclSelectioViewState();
}

class _VehiclSelectioViewState extends State<VehiclSelectioView> {
  var type = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgrounColor,
      appBar: AppBar(
        centerTitle: true,
        title:
            const Text('Choose vehicle', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Column(
        children: [
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: vehicleType.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      type = vehicleType[index];
                    });
                  },
                  child: Card(
                    color:
                        type == vehicleType[index] ? Colors.teal : Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        vehicleType[index],
                        style: TextStyle(
                            color: type == vehicleType[index]
                                ? Colors.white
                                : Colors.teal,
                            fontSize: 26,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                );
              }),
          const Spacer(),
          if (type != '')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                      child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DistanceEntryView(
                                        vehicleType: type,
                                        data: type == 'Auto'
                                            ? fareData[0]
                                            : type == 'Car'
                                                ? fareData[1]
                                                : fareData[2],
                                      )));
                        },
                        child: const Text(
                          "CONFIRM",
                          style: TextStyle(letterSpacing: 1.5),
                        )),
                  )),
                ],
              ),
            ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
