// v1.0 -- non-dynamic version

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sma_app/screens/add_expense/views/add_expense.dart';
import 'package:sma_app/screens/home/views/main_screen.dart';
import 'package:flutter/src/widgets/navigator.dart';

import '../../stats/stats.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen>{

  int index = 0;
  late Color selectedItem = Colors.blue;
  Color unselectedItem = Colors.grey;


  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30)
        ),
        child: BottomNavigationBar(
          onTap: (value){
            setState(() {
              index = value;
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                  CupertinoIcons.home,    // home icon from the bottom of the screen that changes its colour to show that we are in the home screen
                  color: index == 0 ? selectedItem : unselectedItem   // changing colour -> 0 means we clicked home
              ),
              label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                    CupertinoIcons.graph_square_fill,  // statistics screen button that changes colour to indicate which screen are we on
                    color: index == 1 ? selectedItem : unselectedItem   // changing colour -> 1 means we clicked statistics
                ),
                label: 'Stats'
            )
          ]
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AddExpense(),
                ),
            );
          },
            child: const Icon(
              CupertinoIcons.add,    // middle "add" button for adding a new expense to the list
            ),
      ),
      body: index == 0
          ? const MainScreen()
          : const StatScreen()
    );
  }
}