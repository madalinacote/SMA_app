import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sma_app/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget{
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();

  List<String> myCategoriesIcons = [
    'bills',
    'entertainment',
    'food',
    'health',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel'
  ];



  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());   // used for displaying the date correctly
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),  // when you click outside the textboxes, it will unselect the text fields
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Adaugă cheltuieli",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(   // a different field for each detail about the transaction - here is the amount
                  controller: expenseController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                        FontAwesomeIcons.dollarSign,
                        size: 16,
                        color: Colors.grey,
                    ),
                    hintText: 'Suma',  // a hint about what you have to enter in the field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(    // field for selecting the category
                controller: categoryController,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: (){

                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    FontAwesomeIcons.list,
                    size: 16,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            bool isExpanded = false;
                            String iconSelected = '';
                            Color categoryColor = Colors.white;
                            TextEditingController categoryNameController = TextEditingController();
                            TextEditingController categoryIconController = TextEditingController();
                            TextEditingController categoryColorController = TextEditingController();

                            return StatefulBuilder(
                              builder: (ctx, setState) {
                                return AlertDialog(
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
                                          ? Container(
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
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
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
                                      )
                                      : Container(),
                                      const SizedBox(height: 16),
                                      TextFormField( // field for completing with the color of the new category
                                        controller: categoryColorController,
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (ctx2) {
                                                return BlocProvider.value(
                                                  value: context.read<CreateCategoryBloc>(),
                                                  child: AlertDialog(
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
                                        child: TextButton(
                                            onPressed: () {
                                              // create category object and POP
                                              Category category = Category.empty;
                                              category.categoryId = Uuid().v1();
                                              category.name = categoryNameController.text;
                                              category.icon = iconSelected;
                                              category.color = categoryColor.toString();
                                              context.read<CreateCategoryBloc>().add(CreateCategory(category));
                                              Navigator.pop(context);
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
                          }
                      );
                    },
                    icon: const Icon(
                      FontAwesomeIcons.plus,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'Categorie',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(   // field for completing with the date
                controller: dateController,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,   // parameter used for not letting the user write text in the field
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: selectDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365))
                  );
                  if(newDate != null){
                    setState(() {
                      dateController.text = DateFormat('dd/MM/yyyy').format(newDate);
                      selectDate = newDate;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    FontAwesomeIcons.clock,
                    size: 16,
                    color: Colors.grey,
                  ),
                  hintText: 'Data',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      )
                    ),
                    child: const Text(
                      "Salvează",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
