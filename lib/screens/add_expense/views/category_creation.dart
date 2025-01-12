import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sma_app/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:uuid/uuid.dart';

Future getCategoryCreation(BuildContext context) {

  List<String> myCategoriesIcons = ['bills', 'entertainment', 'food', 'health', 'home', 'pet', 'shopping', 'tech', 'travel'];

  return showDialog(
      context: context,
      builder: (ctx) {
        bool isExpanded = false;
        String iconSelected = '';
        Color categoryColor = Colors.white;
        TextEditingController categoryNameController = TextEditingController();
        TextEditingController categoryIconController = TextEditingController();
        TextEditingController categoryColorController = TextEditingController();
        bool isLoading = false;
        Category category = Category.empty;

        return BlocProvider.value(
          value: context.read<CreateCategoryBloc>(),
          child: StatefulBuilder(
          builder: (ctx, setState) {
            return BlocListener<CreateCategoryBloc, CreateCategoryState>(
              listener: (context, state) {
                if (state is CreateCategorySuccess) {
                  Navigator.pop(ctx, category);
                } else if (state is CreateCategoryLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
              },
              child: AlertDialog(
                title: const Text(
                    'Creează o nouă categorie'
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField( // field for completing the name of the new category
                      controller: categoryNameController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Denumire',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius
                                .circular(12),
                            borderSide: BorderSide.none
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField( // field for completing the icon of the new category
                      controller: categoryIconController,
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: true,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        suffixIcon: const Icon(
                          CupertinoIcons.chevron_down,
                          size: 12,),
                        fillColor: Colors.white,
                        hintText: 'Imagine',
                        border: OutlineInputBorder(
                            borderRadius: isExpanded
                                ? const BorderRadius.vertical(
                                top: Radius.circular(12)
                            )
                                : BorderRadius.circular(12),
                            borderSide: BorderSide.none
                        ),
                      ),
                    ),
                    isExpanded
                        ? Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (MediaQuery.of(context).size.width / 100).floor(),
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5
                              ),
                              itemCount: myCategoriesIcons.length,
                              itemBuilder: (context, int i) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      iconSelected = myCategoriesIcons[i];
                                    });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3,
                                            color: iconSelected == myCategoriesIcons[i]
                                                ? Colors.green
                                                : Colors.grey
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/${myCategoriesIcons[i]}.png'
                                            )
                                        )
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                    )
                        : Container(),
                    const SizedBox(height: 16),
                    TextFormField( // field for completing with the color of the new category
                      controller: categoryColorController,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx2) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ColorPicker(
                                      pickerColor: categoryColor,
                                      onColorChanged: (value) {
                                        setState(() {
                                          categoryColor = value;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(ctx2);
                                          },
                                          style: TextButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12)
                                              )
                                          ),
                                          child: const Text(
                                            "OK",
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                          )
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                        );
                      },
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: true,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: categoryColor,
                        hintText: 'Culoare',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: kToolbarHeight,
                      child: isLoading == true
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : TextButton(
                          onPressed: () {
                            // create category object and POP
                            setState(() {
                              category.categoryId = const Uuid().v1();
                              category.name = categoryNameController.text;
                              category.icon = iconSelected;
                              category.color = categoryColor.value;
                            });

                            context.read<CreateCategoryBloc>().add(CreateCategory(category));
                            // Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              )
                          ),
                          child: const Text(
                            "OK",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          ),
        );
      }
  );
}