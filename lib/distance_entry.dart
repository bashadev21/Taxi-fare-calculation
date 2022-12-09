import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taziapp/constants.dart';

class DistanceEntryView extends StatefulWidget {
  final String vehicleType;
  final Map data;
  const DistanceEntryView(
      {super.key, required this.vehicleType, required this.data});

  @override
  State<DistanceEntryView> createState() => _DistanceEntryViewState();
}

class _DistanceEntryViewState extends State<DistanceEntryView> {
  final TextEditingController distanceCon = TextEditingController();
  final TextEditingController hourCon = TextEditingController();
  var total = 0;
  var discount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgrounColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Enter Distance'.toString(),
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Choosed Vehicle : ${widget.vehicleType}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              cursorColor: themeColor,
              maxLength: 4,
              controller: distanceCon,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (distanceCon.text.isNotEmpty && hourCon.text.isNotEmpty) {
                  calculate();
                }
                setState(() {});
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Distance (Km)",
                labelStyle: const TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: themeColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: themeColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              cursorColor: themeColor,
              maxLength: 4,
              controller: hourCon,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (distanceCon.text.isNotEmpty && hourCon.text.isNotEmpty) {
                  calculate();
                }

                setState(() {});
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter waiting Time (Hr)",
                labelStyle: const TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: themeColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: themeColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            if (distanceCon.text.isNotEmpty && hourCon.text.isNotEmpty)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Amount Details',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  RateText(
                    title: 'Base fare :',
                    amount: '${widget.data['base_fare']}',
                  ),
                  RateText(
                    title:
                        'Fare for (${distanceCon.text}km x ₹${widget.data['fare_one_km']}) :',
                    amount:
                        '${int.parse(distanceCon.text) * widget.data['fare_one_km']}',
                  ),
                  RateText(
                    title:
                        'Waiting fare for (${hourCon.text}hr x ₹${widget.data['waiting_fare']}) :',
                    amount:
                        '${int.parse(hourCon.text) * widget.data['waiting_fare']}',
                  ),
                  // ignore: unrelated_type_equality_checks
                  if (widget.data['discount'] != 'nil')
                    RateText(
                      title: 'Discount :',
                      amount: '$discount',
                    ),
                  RateText(
                    title: 'Total amount :',
                    amount: total.toString(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void calculate() {
    if (widget.data['discount'] != 'nil') {
      total = widget.data['base_fare'] +
          widget.data['fare_one_km'] * int.parse(distanceCon.text) +
          widget.data['waiting_fare'] * int.parse(hourCon.text);
      discount = (total / 100 * widget.data['discount']).toInt();
      discount = discount > widget.data['max_discount']
          ? widget.data['max_discount']
          : discount;
      total = total - discount;
    } else {
      total = widget.data['base_fare'] +
          widget.data['fare_one_km'] * int.parse(distanceCon.text) +
          widget.data['waiting_fare'] * int.parse(hourCon.text);
    }
  }
}

class RateText extends StatelessWidget {
  final String title, amount;
  const RateText({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Text(
            '₹ $amount',
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
