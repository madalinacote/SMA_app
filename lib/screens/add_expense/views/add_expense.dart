import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sma_app/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:sma_app/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:sma_app/screens/add_expense/views/category_creation.dart';
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
  //DateTime selectDate = DateTime.now();
  late Expense expense;
  bool isLoading = false;

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());   // used for displaying the date correctly
    expense = Expense.empty;
    expense.expenseId = Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if(state is CreateExpenseSuccess) {
          Navigator.pop(context, expense);
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
    child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),  // when you click outside the textboxes, it will unselect the text fields
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
          builder: (context, state) {
            if(state is GetCategoriesSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
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
                        child: TextFormField( // a different field for each detail about the transaction - here is the amount
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
                            hintText: 'Suma',
                            // a hint about what you have to enter in the field
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField( // field for selecting the category
                        controller: categoryController,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        onTap: () {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: expense.category == Category.empty
                          ? Colors.white
                          : Color(expense.category.color),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: expense.category == Category.empty
                            ? const Icon(
                                FontAwesomeIcons.list,
                                size: 16,
                                color: Colors.grey,
                              )
                            : SizedBox(
                              width: 16,
                              height: 16,
                              child: Image.asset(
                                  'assets/${expense.category.icon}.png',
                                  fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              var newCategory = await getCategoryCreation(context);
                              print(newCategory);
                              setState(() {
                                state.categories.insert(0, newCategory);
                              });
                            },
                            icon: const Icon(
                              FontAwesomeIcons.plus,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: 'Categorie',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)
                              ),
                              borderSide: BorderSide.none
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12)
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: state.categories.length,
                              itemBuilder: (context, int i) {
                                return Card(
                                  child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          expense.category = state.categories[i];
                                          categoryController.text = expense.category.name;
                                        });
                                      },
                                      leading: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image.asset(
                                          'assets/${state.categories[i].icon}.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      title: Text(
                                          state.categories[i].name
                                      ),
                                      tileColor: Color(
                                        state.categories[i].color),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)
                                        )
                                  ),
                                );
                            }
                            )
                        )
                      ),
                      const SizedBox(height: 16),
                      TextFormField( // field for completing with the date
                        controller: dateController,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        // parameter used for not letting the user write text in the field
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: expense.date,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                  const Duration(days: 365))
                          );
                          if (newDate != null) {
                            setState(() {
                              dateController.text = DateFormat('dd/MM/yyyy').format(newDate);
                              expense.date = newDate;
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
                        child: isLoading
                          ? Center(
                            child: CircularProgressIndicator()
                          )
                          : TextButton(
                            onPressed: () {
                              setState(() {
                                expense.amount = int.parse(expenseController.text);
                              });
                              context.read<CreateExpenseBloc>().add(CreateExpense(expense));
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                )
                            ),
                            child: const Text(
                              "Salvează",
                              style: TextStyle(color: Colors.white),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ),
    ),
);
  }
}
