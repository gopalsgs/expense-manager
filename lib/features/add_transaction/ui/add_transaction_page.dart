import 'package:expense_manager/core/ui_util.dart';
import 'package:expense_manager/model/category_model.dart';
import 'package:expense_manager/model/transaction_model.dart';

import '../bloc/add_transaction_bloc.dart';
import '../../categories/bloc/categories_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewItem extends StatefulWidget {
  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final remarkController = TextEditingController();

  final priceController = TextEditingController();

  final priceFocus = FocusNode();

  void _onSubmit(context) async {
    if (provider.selectedCategory.id.isNotEmpty) {
      UIUtils.showSnackBar(
        context: context,
        text: 'Select a Category',
      );
      return;
    }
    if (remarkController.text.isNotEmpty && priceController.text.isNotEmpty) {
      await provider.addNewTransaction(
        transaction: TransactionModel(
          remark: remarkController.text.trim(),
          price: int.tryParse(priceController.text.trim()) ?? 0,
          categoryId: provider.selectedCategory.id,
        ),
      );

      Navigator.pop(context);
    }
  }

  AddTransactionBloc provider;
  @override
  void initState() {
    provider = AddTransactionBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Transaction'),
        ),
        body: ChangeNotifierProvider(
          create: (_) => provider,
          child: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      _buildCategoryWidget(context),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: remarkController,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(priceFocus);
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(hintText: 'Remark'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        focusNode: priceFocus,
                        controller: priceController,
                        keyboardType: TextInputType.numberWithOptions(),
                        onEditingComplete: () {
                          _onSubmit(context);
                        },
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(hintText: 'Amount'),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _onSubmit(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('ADD'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffFB8080),
                        ),
                        onPressed: () {
                          _showDialog(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('Add New Category'.toUpperCase()),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  final _selectCategoryItem = DropdownMenuItem<CategoryModel>(
    child: Text('Select Category'),
    value: CategoryModel(id: '', name: 'Select Category'),
  );

  Widget _buildCategoryWidget(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: Colors.indigoAccent)),
      child: StreamBuilder<List<CategoryModel>>(
        stream: Provider.of<CategoriesBloc>(context).getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return Container();
            }
            return DropdownButton<CategoryModel>(
              value: Provider.of<AddTransactionBloc>(context).selectedCategory,
              isExpanded: true,
              iconEnabledColor: Colors.black,
              isDense: false,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Segoe UI',
                color: Colors.black,
              ),
              underline: Divider(
                color: Colors.transparent,
              ),
              items: snapshot.data
                  .map(
                    (e) => DropdownMenuItem<CategoryModel>(
                      child: Text(e.name),
                      value: e,
                    ),
                  )
                  .toList()
                    ..remove(_selectCategoryItem)
                    ..insert(
                      0,
                      _selectCategoryItem,
                    ),
              onChanged: (CategoryModel value) {
                Provider.of<AddTransactionBloc>(
                  context,
                  listen: false,
                ).selectedCategory = value;
              },
            );
          }

          return Container();
        },
      ),
    );
  }

  void _showDialog(BuildContext buildContext) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: buildContext,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  autofocus: true,
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'Category Name',
                    hintText: '',
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (controller.text.trim().isEmpty) {
                  UIUtils.showSnackBar(context: context, text: 'Name is Empty');
                  return;
                }
                Provider.of<CategoriesBloc>(
                  buildContext,
                  listen: false,
                ).addNewCategory(
                  buildContext,
                  controller.text.trim(),
                );
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
