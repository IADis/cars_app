import 'package:cars_app/bloc/cars_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarCars extends StatefulWidget implements PreferredSizeWidget {
  const AppBarCars({super.key});

  @override
  State<AppBarCars> createState() => _AppBarCarsState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppBarCarsState extends State<AppBarCars> {
  List<String> filtres = [
    'По цене',
    'По названию',
    'По году',
  ];

  String? valueFiltres;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SizedBox(
        height: 50,
        child: TextField(
          onChanged: (text) {
            BlocProvider.of<CarsBloc>(context).add(SearchCars(text));
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2),
                borderRadius: BorderRadius.circular(15),
              )),
        ),
      ),
      actions: [
        DropdownButton(
            value: valueFiltres,
            items: filtres
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              switch (value) {
                case 'По цене':
                  BlocProvider.of<CarsBloc>(context)
                      .add(FiltresCars(Filtres.byPrice));
                  break;
                case 'По названию':
                  BlocProvider.of<CarsBloc>(context)
                      .add(FiltresCars(Filtres.byName));
                  break;
                case 'По году':
                  BlocProvider.of<CarsBloc>(context)
                      .add(FiltresCars(Filtres.byYear));
                  break;
              }
              valueFiltres = value;
              setState(() {});
            })
      ],
      elevation: 0,
    );
  }
}
