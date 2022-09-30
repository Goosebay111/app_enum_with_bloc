import 'package:app_enum_with_bloc/blocs/selected/bloc_events.dart';
import 'package:app_enum_with_bloc/blocs/selected/bloc_state.dart';
import 'package:app_enum_with_bloc/blocs/selected/item_bloc.dart';
import 'package:app_enum_with_bloc/enums/weapon_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  int _getSum(item) =>
      item.fold(0, (previousValue, element) => previousValue + element.bonus());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedBloc, SelectedState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('App Enum with BLoC'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 100,
                child: Text(_getSum(state.selectedItems).toString()),
              ),
              Wrap(
                children: [
                  ...Item.values
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: ActionChip(
                              backgroundColor: state.selectedItems.contains(e)
                                  ? Colors.blue
                                  : null,
                              label: Text(
                                e.name.toString(),
                              ),
                              onPressed: () {
                                state.selectedItems.contains(e)
                                    ? BlocProvider.of<SelectedBloc>(context)
                                        .add(RemoveItem(e))
                                    : BlocProvider.of<SelectedBloc>(context)
                                        .add(AddItem(e));
                              },
                            ),
                          ))
                      .toList(),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
