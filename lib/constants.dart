import 'package:flutter/material.dart';

const backgrounColor = Color.fromARGB(136, 61, 55, 55);
const themeColor = Colors.teal;

var vehicleType = ['Car', 'Auto', 'Van'];
var fareData = [
  {
    "type": "auto",
    "base_fare": 30,
    "fare_one_km": 12,
    "waiting_fare": 80,
    "discount": "nil",
    "max_discount": "nil"
  },
  {
    "type": "car",
    "base_fare": 60,
    "fare_one_km": 21,
    "waiting_fare": 150,
    "discount": 5,
    "max_discount": 50
  },
  {
    "type": "van",
    "base_fare": 100,
    "fare_one_km": 25,
    "waiting_fare": 200,
    "discount": 10,
    "max_discount": 100
  },
];
