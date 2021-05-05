import '../../add_transaction/bloc/add_transaction_bloc.dart';
import '../../categories/bloc/categories_bloc.dart';
import '../bloc/transaction_bloc.dart';
import '../../../model/category_model.dart';
import '../../../model/transaction_model.dart';

import '../../Widgets/transaction_item.dart';
import '../../add_transaction/ui/add_transaction_page.dart';
import '../../../repo/transaction_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Theme(
            child: _buildCategoryWidget(context),
            data: ThemeData(canvasColor: Colors.indigoAccent)),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => NewItem()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xffFB8080),
      ), //

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: StreamBuilder<List<TransactionModel>>(
        stream: Provider.of<TransactionBloc>(context).getAllTransactionStream(),
        builder: (context, snapshot) {
          final provider = Provider.of<TransactionBloc>(context);

          if (snapshot.hasData) {
            List<TransactionModel> list = snapshot.data;
            if (provider.selectedCategory.id.isNotEmpty) {
              list = list
                  .where(
                    (element) =>
                        element.categoryId == provider.selectedCategory.id,
                  )
                  .toList();
            }

            return list.isEmpty
                ? Center(child: Text('No Expenses Added.'))
                : Builder(
                    builder: (context) {
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return TransactionItemWidget(list[index]);
                        },
                      );
                    },
                  );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  final _selectCategoryItem = DropdownMenuItem<CategoryModel>(
    child: Text('All Category'),
    value: CategoryModel(id: '', name: 'All Category'),
  );

  Widget _buildCategoryWidget(context) {
    return StreamBuilder<List<CategoryModel>>(
      stream: Provider.of<CategoriesBloc>(context).getAllCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Container();
          }
          return DropdownButton<CategoryModel>(
            value: Provider.of<TransactionBloc>(context).selectedCategory,
            isExpanded: false,
            iconEnabledColor: Colors.white,
            isDense: false,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Segoe UI',
              color: Colors.white,
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
              Provider.of<TransactionBloc>(
                context,
                listen: false,
              ).selectedCategory = value;
            },
          );
        }

        return Container();
      },
    );
  }
}
