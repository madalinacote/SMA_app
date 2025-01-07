import 'package:flutter/material.dart';

// creating a dynamic list for the "database" concept so we can have more categories of transactions to display

List<Map<String, dynamic>> transactionsData = [
  {
    'icon': Icons.fastfood,
    'color': Colors.yellow[700],
    'name': 'Mâncare',
    'totalAmount': '-45.00 RON' ,
    'date': 'Azi',
  },
  {
    'icon': Icons.shopping_bag,
    'color': Colors.purple,
    'name': 'Cumpărături',
    'totalAmount': '-230.00 RON' ,
    'date': 'Azi',
  },
  {
    'icon': Icons.monitor_heart,
    'color': Colors.green,
    'name': 'Sănătate',
    'totalAmount': '-79.00 RON' ,
    'date': 'Ieri',
  },
  {
    'icon': Icons.card_travel,
    'color': Colors.lightBlueAccent[700],
    'name': 'Călătorii',
    'totalAmount': '-2000.00 RON' ,
    'date': 'Ieri',
  },
];