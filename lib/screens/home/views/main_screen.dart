// v1.0 -- non-dynamic version

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sma_app/data/data.dart';

class MainScreen extends StatelessWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context){
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            children:[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,   // icon for the current user
                              color: Colors.lightBlue[400]
                            ),
                          ),
                          Icon(
                              CupertinoIcons.person_fill,
                              color: Colors.blue[900],
                          )
                        ],
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bun venit!",  // welcome message
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.outline
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.settings))   // when we will tap on the icon, we will enter the settings screen (v1.0)
                ],
              ),
              const SizedBox(height: 20),     // the main card of the screen -- with main and compressed info about total amount, expenses and savings
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors:[
                      Theme.of(context).colorScheme.tertiary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary
                    ],
                    transform: const GradientRotation(pi/4),
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.shade400,
                      offset: const Offset(5, 5)
                    )
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Suma totală',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '4700 RON',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                  color: Colors.white30,
                                  shape: BoxShape.circle
                                ),
                                child: const Center(
                                  child: Icon(
                                      CupertinoIcons.arrow_down,
                                      size: 12,
                                      color: Colors.greenAccent,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Venit',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Text(
                                    '2450.00 RON',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                    color: Colors.white30,
                                    shape: BoxShape.circle
                                ),
                                child: const Center(
                                  child: Icon(
                                    CupertinoIcons.arrow_up,
                                    size: 12,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cheltuieli',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Text(
                                    '1240.00 RON',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(    // transaction summary -- with category, amount and date
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tranzacții',
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  GestureDetector(  // v1.0 -- soon to be updated and when we'll tap it, we'll enter the screen with all the transactions
                    onTap: () {

                    },
                    child: Text(
                      'Vezi toate',
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.outline,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(    // added for having different categories of transactions -- "database" concept
                  itemCount: transactionsData.length,
                    itemBuilder: (context, int i){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: transactionsData[i]['color'],
                                            shape: BoxShape.circle
                                          ),
                                        ),
                                        Icon(
                                          transactionsData[i]['icon'],
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      transactionsData[i]['name'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      transactionsData[i]['totalAmount'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    Text(
                                      transactionsData[i]['date'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context).colorScheme.outline,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              )
            ],
          ),
        ),
    );
  }
}